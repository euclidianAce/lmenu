
local getchar = require("lgetchar").getchar

local list = {}
list.__index = list

function list.new(selector, selected)
	return setmetatable({
		selector = selector or " > ",
		selected = selected or 1,
		options = {},
	}, list)
end

function list:add(content, callback)
	table.insert(self.options, {
		content = content,
		callback = callback
	})
	return self
end

function list:draw()
	for i, v in ipairs(self.options) do
		io.write(i == self.selected and self.selector or (" "):rep(#self.selector))
		io.write(v.content)
		io.write("\n")
	end
end

function list:resetCursor()
	local esc = string.char(27) .. "["
	for i = 1, #self.options do
		io.write(esc .. "A")
		io.write(esc .. "K")
	end
end

function list:__call()
	local running = true
	while running do
		self:draw()
		local chars = {getchar()}
		if #chars == 1 and chars[1] == 10 then
			running = false
		elseif chars[1] == 27 and chars[2] == 91 then
			if chars[3] == 65 then --up
				self.selected = math.max(self.selected - 1, 1)
			elseif chars[3] == 66 then --down
				self.selected = math.min(self.selected + 1, #self.options)
			end
		end
		self:resetCursor()
	end
	return self.options[self.selected].callback()
end

return list
