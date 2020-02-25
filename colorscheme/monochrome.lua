
local ANSI = require("lmenu.ANSI")
local c = ANSI.color
local b = ANSI.color.bright

local cs = setmetatable({
	title = b.white,

	option = c.white,
	selected = b.white,
	checkbox = b.black,
	char = c.white,

	selector = c.white,

	default = b.black,
	paren = b.black,
	sep = b.black,

	positive = b.white,
	negative = c.white,
}, {
	__index = function()
		return ANSI.color.white
	end
})

return cs
