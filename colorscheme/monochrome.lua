
local ANSI = require("lmenu.ANSI")
local c = ANSI.color
local b = ANSI.color.bright

local cs = setmetatable({
	title = b.white,
	question = b.white,
	option = c.white,
	selector = c.white,
	default = b.black,
	paren = b.black,
	checkbox = b.black,
	char = c.white,
	sep = b.black,
}, {
	__index = function()
		return ANSI.color.white
	end
})

return cs
