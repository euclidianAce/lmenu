
local ANSI = require("lmenu.ANSI")
local c = ANSI.color
local b = ANSI.color.bright

local cs = setmetatable({
	title = b.cyan,
	question = b.cyan,

	option = b.white,
	checkbox = b.blue,
	char = c.blue,

	selector = b.green,

	default = b.black,
	paren = b.black,
	sep = b.black,

	positive = b.green,
	negative = b.red,
}, {
	__index = function()
		return ANSI.color.white
	end
})

return cs
