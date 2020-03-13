
local Menu = require("lmenu.Menu")
local draw = require("lmenu.draw")
local ANSI = require("lmenu.ANSI")

local prompt = Menu.new()
prompt.default = ""
prompt.callback = function(input) return input end
prompt.callbackArgs = {}

function prompt:draw()
	if self.title then
		draw.title(self.title)
		draw.space()
	end
	if self.default ~= "" then
		draw.paren("(")
		draw.default(self.default)
		draw.paren(")")
		draw.space()
	end
end

function prompt:run()
	self:draw()
	local input = io.read()
	if input == "" then input = self.default end
	ANSI.cursor.up()
	ANSI.clrln()

	draw.title(self.title)
	draw.space()
	draw.selected(input)
	draw.nl()

	self.callback(input, table.unpack(self.callbackArgs))
	return input
end

return prompt
