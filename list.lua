
local getkey = require("lgetchar").getCharOrEscSeq

local list = {}
list.__index = list

function list.new(title, selector, selected)
	return setmetatable({
		title = title,
		selector = selector or " -> ",
		selected = selected or 1,
		options = {},
	}, list)
end

function list:setTitle(title)
	self.title = title
	return self
end
function list:setSelector(selector)
	self.selector = selector
	return self
end

function list:add(content, callback, ...)
	table.insert(self.options, {
		content = content,
		callback = callback or function()
			return content
		end,
		callbackArgs = {...},
	})
	return self
end

function list:draw()
	if self.title then
		io.write(self.title, "\n")
	end
	for i, v in ipairs(self.options) do
		io.write(i == self.selected and self.selector or (" "):rep(#self.selector))
		io.write(v.content, "\n")
	end
end

function list:resetCursor()
	local esc = string.char(27) .. "["
	local len = #self.options + (self.title and 1 or 0)
	for i = 1, len do
		io.write(esc .. "A")
		io.write(esc .. "K")
	end
end

function list:cursorUp()
	self.selected = self.selected - 1
	if self.selected < 1 then
		self.selected = #self.options
	end
end

function list:cursorDown()
	self.selected = self.selected + 1
	if self.selected > #self.options then
		self.selected = 1
	end
end

list.keyhandles = {
	[10] = function() return false end, -- enter
	[106] = function(self) -- j
		self:cursorDown()
		return true
	end,
	[107] = function(self) -- k
		self:cursorUp()
		return true
	end,
	[27] = {
		[91] = {
			[65] = function(self)
				self:cursorUp()
				return true
			end,
			[66] = function(self)
				self:cursorDown()
				return true
			end,
		},
	},
}

function list:handlekeys()
	local kh = self.keyhandles
	for i, v in ipairs{getkey()} do
		kh = kh[v]
		if not kh then
			return true
		end
	end
	return kh(self)
end

function list:run()
	local running = true
	while running do
		self:draw()
		running = self:handlekeys()
		self:resetCursor()
	end
end

function list:__call()
	self:run()
	local selected = self.selected
	local opt = self.options[selected]
	
	if self.title then
		io.write(self.title, " ")
	end
	io.write(opt.content, "\n")
	return opt.callback(table.unpack(opt.callbackArgs))
end


return list
