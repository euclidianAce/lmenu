
local list = require("lmenu.list")

local checklist = {}
function checklist:__index(key) -- inherits from list
	if not checklist[key] then
		return list[key]
	end
	return checklist[key]
end

function checklist.new(title, selector, check, checkbox)
	return setmetatable({
		options = {},
		title = title,
		selected = 1,
		selector = selector or "> ",
		check = check or "*",
		checkbox = checkbox or "[%s]"
	}, checklist)
end

function checklist:setCheck(check)
	self.check = check
	return self
end

function checklist:setCheckbox(checkbox)
	self.checkbox = checkbox
	return self
end

function checklist:draw()
	if self.title then
		io.write(self.title, "\n")
	end
	for i, v in ipairs(self.options) do
		io.write(i == self.selected and self.selector or (" "):rep(#self.selector))
		io.write(self.checkbox:format(
			v.checked and self.check
			or (" "):rep(#self.check)
		))
		io.write(" ", v.content, "\n")
	end
end

checklist.keyhandles = {
	[32] = function(self)
		self.options[self.selected].checked = not self.options[self.selected].checked
		return true
	end,
}
setmetatable(checklist.keyhandles, {__index = list.keyhandles})

function checklist:__call()
	self:run()
	local rvals = {}
	if self.title then
		io.write(self.title, "\n")
	end
	for i, v in ipairs(self.options) do
		if v.checked then
			io.write(
				(" "):rep(
					#self.check +
					#(self.checkbox:format(self.check))
				)
			)
			io.write(v.content, "\n")
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
