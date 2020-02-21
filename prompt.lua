
local draw = require("lmenu.draw")
local ANSI = require("lmenu.ANSI")

local prompt = {}
prompt.__index = prompt

function prompt.new(question, default, callback, ...)
	return setmetatable({
		question = question,
		default = default or "",
		callback = callback or function(input) 
			return input
		end,
		callbackArgs = {},
	}, prompt)
end

function prompt:draw()
	draw.question(self.question)
	draw.qmark("?")
	draw.space()
	if self.default ~= "" then
		draw.paren("(")
		draw.default(self.default)
		draw.paren(")")
		draw.space()
	end
end

function prompt:__call()
	self:draw()
	local input = io.read()
	if input == "" then input = self.default end
	ANSI.cursor.up()
	ANSI.clrln()

	draw.question(self.question)
	draw.space()
	draw.option(input)
	draw.nl()

	self.callback(input, table.unpack(self.callbackArgs))
	return input
end

return prompt
