
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
				draw.option(v)
				draw.nl()
			end
		end
	else
		for i, v in ipairs(self.options) do
			draw.selector(i == self.selected and self.selector or (" "):rep(#self.selector))
			draw.checkbox(self.checkbox:format(
				v.checked and self.check
				or (" "):rep(#self.check)
			))
			draw.option(v)
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
				vals = {v.callback()}
			end
			vals.num = i
			table.insert(rvals, vals)
		end
	end
	return rvals
end

return checklist
