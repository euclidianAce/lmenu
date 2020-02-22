
local Menu = require("lmenu.Menu")
local draw = require("lmenu.draw")
local ANSI = require("lmenu.ANSI")

local prompt = Menu.new()
prompt.default = ""
prompt.callback = function(input) return input end
prompt.callbackArgs = {}

function prompt:setQuestion(str)
	self.question = str
	return self
end
function prompt:setDefault(str)
	self.default = str
	return self
end

function prompt:draw()
	if self.question then
		draw.question(self.question)
	end
	draw.qmark("?")
	draw.space()
	if self.default ~= "" then
		draw.paren("(")
		draw.default(self.default)
		draw.paren(")")
		draw.space()
	end
end

function prompt.metamethods:__call()
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
