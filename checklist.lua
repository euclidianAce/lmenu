
local getchar = require("lgetchar").getchar

local checklist = {}
checklist.__index = checklist

function checklist.new(selector, check, checkbox)
	return setmetatable({
		options = {},
		selected = 1,
		selector = selector or "> ",
		check = check or "*",
		checkbox = checkbox or "[%s]"
	}, checklist)
end

function checklist:add(option, checked, callback)
	table.insert(self.options, {
		content = option, 
		checked = checked,
		callback = callback
	})
	return self
end

function checklist:draw()
	for i, v in ipairs(self.options) do
		io.write(i == self.selected and self.selector or (" "):rep(#self.selector))
		io.write(self.checkbox:format(
			v.checked and self.check
			or (" "):rep(#self.check)
		))
		io.write(" ")
		io.write(v.content)
		io.write("\n")
	end
end

function checklist:resetCursor()
	local esc = string.char(27) .. "["
	for i = 1, #self.options do
		io.write(esc .. "A")
		io.write(esc .. "K")
	end
end

function checklist:__call()
	local running = true
	while running do
		self:draw()
		local chars = {getchar()}
		if #chars == 1 then
			if chars[1] == 10 then -- enter
				running = false
			elseif chars[1] == 32 then -- space
				self.options[self.selected].checked = not self.options[self.selected].checked
			end
		elseif chars[1] == 27 and chars[2] == 91 then
			if chars[3] == 65 then --up
				self.selected = math.max(self.selected - 1, 1)
			elseif chars[3] == 66 then --down
				self.selected = math.min(self.selected + 1, #self.options)
			end
		end
		self:resetCursor()
	end
	local rvals = {}
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
