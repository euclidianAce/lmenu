
local getchar = require("lgetchar").getchar

local charprompt = {}
charprompt.__index = charprompt

function charprompt.new(text)
	return setmetatable({
		text = text,
		options = {}
	}, charprompt)
end

function charprompt:add(char, callback)
	if type(char) == "string" then
		char = string.byte(char)
	end
	table.insert(self.options, {
		char = char,
		callback = callback or function()
			return char
		end
	})
	return self
end

function charprompt:decorate(left, right)
	local c = self.options
	local index = #self.options
	c[index].left = left
	c[index].right = right
	return self
end

local function writeChar(options)
	local left, right = options.left, options.right
	local char = options.char
	if left then
		io.write(left)
	end
	io.write(string.char(char))
	if right then
		io.write(right)
	end
end

function charprompt:draw()
	io.write(self.text or "", " [")
	for i, v in ipairs(self.options) do
		writeChar(v)
		io.write(i < #self.options and "/" or "")
	end
	io.write("]")
end

function charprompt:resetCursor()
	io.write(string.char(27) .. "[G")
	io.write(string.char(27) .. "[K")
end

function charprompt:__call()
	self:draw()
	local running = true
	local c
	while running do
		c = getchar()
		for i, v in ipairs(self.options) do
			if v.char == c then
				c = v
				running = false
			end
		end
	end
	self:resetCursor()
	io.write(self.text or "", " ")
	writeChar(c)
	io.write("\n")
	return c.callback()
end

return charprompt
