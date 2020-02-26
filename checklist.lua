
local Menu = require("lmenu.Menu")
local draw = require("lmenu.draw")
local list = require("lmenu.list")

local checklist = Menu.new(list)
checklist.check = "*"
checklist.checkbox = "[%s]"
checklist.checks = setmetatable({}, {__index = function() return false end})

local function getContent(option)
	return option.content or option[1] or option
end

function checklist:draw(sel)
	if self.title then
		draw.title(self.title)
	end
	if sel then
		draw.nl()
		for i, v in ipairs(self.options) do
			local content = getContent(v)
			if self.checks[i] then
				draw.space()
				draw.selected(content)
				draw.nl()
			end
		end
	else
		draw.nl()
		for i, v in ipairs(self.options) do
			local content = getContent(v)
			if i == self.selected then
				draw.selector(self.selector)
			else
				draw.space(#self.selector)
			end
			draw.checkbox(self.checkbox:format(
				self.checks[i] and self.check
				or (" "):rep(#self.check)
			))
			draw.space()
			if self.checks[i] then
				draw.selected(content)
			else
				draw.option(content)
			end
			draw.nl()
		end
	end
end

checklist.keyhandles = {
	[32] = function(self)
		--self.options[self.selected].checked = not self.options[self.selected].checked
      if not rawget(self, "checks") then
         self.checks = {}
      end
		self.checks[self.selected] = not self.checks[self.selected]
		return true
	end,
}
setmetatable(checklist.keyhandles, {__index = list.keyhandles})

function checklist.metamethods:__call()
	self:draw()
	while self:handlekeys() do
		self:resetCursor()
		self:draw()
	end
	local rvals = {}
	self:resetCursor()
	self:draw(true)
	for i, v in ipairs(self.options) do
		if self.checks[i] then
			local vals = {}
			if v.callback then
				if v.callbackArgs then
					vals = {v.callback(table.unpack(v.callbackArgs))}
				else
					vals = {v.callback()}
				end
			end
			vals.num = i
			table.insert(rvals, vals)
		end
	end
	return rvals
end

return checklist
