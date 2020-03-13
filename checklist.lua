
local Menu = require("lmenu.Menu")
local draw = require("lmenu.draw")
local list = require("lmenu.list")

---@class checklist : list
---@field check string
---@field checkbox string
local checklist = Menu.new(list)
checklist.check = "*"
checklist.checkbox = "[%s]"

---Gets the content of an option regardless of the type
---@param option table|string
---@return string
local function getContent(option)
	return option.content or option[1] or option
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
			local content = getContent(v)
        local checked = v.checked
			if checked then
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
				v.checked and self.check
				or (" "):rep(#self.check)
			))
			draw.space()
			if v.checked then
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
		if type(self.options[self.selected]) ~= "table" then
			self.options[self.selected] = {self.options[self.selected]}
		end
		self.options[self.selected].checked = not self.options[self.selected].checked
		return true
	end,
}
setmetatable(checklist.keyhandles, {__index = list.keyhandles})

function checklist:run()
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
