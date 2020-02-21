
local draw = require("lmenu.draw")
local ANSI = require("lmenu.ANSI")
local getchar = require("lgetchar").getchar

local charprompt = {}
charprompt.__index = charprompt

function charprompt.new(question)
	return setmetatable({
		question = question,
		default = 1,
		options = {},
	}, charprompt)
end

function charprompt:add(char, callback, ...)
	if type(char) == "string" then
		char = string.byte(char)
	end
	table.insert(self.options, {
		char = char,
		callback = callback or function()
			return char
		end,
		callbackArgs = {...}
	})
	return self
end

function charprompt:setDefault(n)
	self.default = n
	return self
end

local function writeChar(options, upper)
	local char = options.char
	if upper then
		draw.char(string.char(char):upper())
	else
		draw.char(string.char(char))
	end
end

function charprompt:draw(n)
	if self.question then
		draw.question(self.question)
		draw.space()
	end
	if n then
		draw.char(string.char(n))
	else
		draw.paren('[')
		for i, v in ipairs(self.options) do
			writeChar(v, i == self.default)
			draw.sep(i < #self.options and "/" or "")
		end
		draw.paren(']')
	end
end

function charprompt:resetCursor()
	ANSI.cursor.column(1)
	ANSI.clrln()
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
		if c == 10 then -- enter for default
			c = self.options[self.default]
			running = false
		end
	end
	self:resetCursor()
	self:draw(c.char)
	draw.nl()
	return c.callback(table.unpack(c.callbackArgs))
end

return charprompt
