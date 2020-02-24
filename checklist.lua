
local Menu = require("lmenu.Menu")
local draw = require("lmenu.draw")
local list = require("lmenu.list")

local checklist = Menu.new(list)
checklist.check = "*"
checklist.checkbox = "[%s]"

function checklist:setCheck(check)
	self.check = check
	return self
end

function checklist:setCheckbox(checkbox)
	self.checkbox = checkbox
	return self
end

function checklist:draw(sel)
	if self.title then
		draw.title(self.title)
		draw.nl()
	end
	if sel then
		for i, v in ipairs(self.options) do
			if v.checked then
				draw.space()
				draw.selected(v)
				draw.nl()
			end
		end
	else
		for i, v in ipairs(self.options) do
			if i == self.selected then
				draw.selector(self.selector)
			else
				draw.space(#self.selector)
			end
			draw.checkbox(self.checkbox:format(
				v.checked and self.check
				or (" "):rep(#self.check)
			))
			draw.space()
			if v.checked then
				draw.selected(v)
			else
				draw.option(v)
			end
			draw.nl()
		end
	end
end

checklist.keyhandles = {
	[32] = function(self)
		self.options[self.selected].checked = not self.options[self.selected].checked
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
		if v.checked then
			local vals = {}
			if v.callback then
				vals = {v.callback(table.unpack(v.callbackArgs))}
			end
			vals.num = i
			table.insert(rvals, vals)
		end
	end
	return rvals
end

return checklist
