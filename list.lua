
local Menu = require("lmenu.Menu")
local ANSI = require("lmenu.ANSI")
local draw = require("lmenu.draw")
local lgetchar = require("lgetchar")
local function getkey()
	local c = lgetchar.getChar()
	local d, e
	if c == 27 then
		d = lgetchar.getChar()
		e = lgetchar.getChar()
	end
	return c, d, e
end

local list = Menu.new()
list.selector = " -> "
list.selected = 1
list.options = {}

function list:setTitle(title)
	self.title = title
	return self
end
function list:setSelector(selector)
	self.selector = selector
	return self
end
function list:add(content, callback, ...)
	if not rawget(self, "options") then
		self.options = {}
	end
	table.insert(self.options, {
		content = content,
		callback = callback or function()
			return content
		end,
		callbackArgs = {...},
	})
	return self
end

function list:resetCursor()
	local len = #self.options + (self.title and 1 or 0)
	for i = 1, len do
		ANSI.cursor.up()
		ANSI.clrln()
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

function list:draw(sel)
	if self.title then
		draw.title(self.title)
		draw.space()
	end
	if sel then
		draw.option(self.options[self.selected])
		draw.nl()
	else
		if self.title then
			draw.nl()
		end
		for i, v in ipairs(self.options) do
			draw.selector(i == self.selected and self.selector or (" "):rep(#self.selector))
			draw.option(v)
			draw.nl()
		end
	end
end
function list:run()
	local running = true
	while running do
		self:draw()
		running = self:handlekeys()
		self:resetCursor()
	end
	local selected = self.selected
	local opt = self.options[selected]
	self:draw(true)
	if opt.callback then
		if opt.callbackArgs then
			return opt.callback(table.unpack(opt.callbackArgs))
		end
		return opt.callback()
	end
end

list.metamethods.__call = list.run

return list
