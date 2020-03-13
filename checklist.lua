
local Menu = require("lmenu.Menu")
local draw = require("lmenu.draw")
local list = require("lmenu.list")
local utils = require("lmenu.utils")
local ANSI = require("lmenu.ANSI")

---@class checklist : list
---@field check string
---@field checkbox string
local checklist = Menu.new(list)
checklist.check = "*"
checklist.checkbox = "[%s]"

---@overload
---@param index number
function checklist:drawIndex(index)
	local checked = self.options[index].checked
	local option = self.options[index]
	ANSI.clrln(2)
	ANSI.cursor.column(1)
	if self.selected == index then
		draw.selector(self.selector)
	else
		draw.space(#self.selector)
	end
	draw.checkbox(self.checkbox:format(
		checked and self.check
		or (" "):rep(#self.check)
	))
	if checked then
		draw.selected(option)
	else
		draw.option(option)
	end
	ANSI.cursor.column(1)
end


---Draws the list, if sel is true then draw the list in its finished state
---@overload
---@param sel boolean
---@return nil
function checklist:draw(sel)
	if self.title then
		draw.title(self.title)
	end
	if sel then
		draw.nl()
		for i, v in ipairs(self.options) do
			local content = utils.getContent(v)
			if v.checked then
				draw.space()
				draw.selected(content)
				draw.nl()
			end
		end
	else
		draw.nl()
		for i = 1, #self.options do
			self:drawIndex(i)
			draw.nl()
		end
	end
end

checklist.keyhandles = {
	[32] = function(self)
		if type(self.options[self.selected]) ~= "table" then
			self.options[self.selected] = {self.options[self.selected]}
		end
		self.options[self.selected].checked = not self.options[self.selected].checked
		return true
	end,
}
setmetatable(checklist.keyhandles, {__index = list.keyhandles})

function checklist:run()
	self:input()
	local rvals = {}
	for i, v in ipairs(self.options) do
		if v.checked then
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
