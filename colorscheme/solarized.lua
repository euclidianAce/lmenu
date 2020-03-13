
local ANSI = require("lmenu.ANSI")
local c = ANSI.fg

local solarized = setmetatable({}, {
	__index = function(self)
		return self.blue
	end
})

solarized.base03 = c"002b36"
solarized.base02 = c"073642"
solarized.base01 = c"586e75"
solarized.base00 = c"657b83"
solarized.base0 = c"839496"
solarized.base1 = c"93a1a1"
solarized.base2 = c"eee8d5"
solarized.base3 = c"fdf6e3"

solarized.yellow = c"b58900"
solarized.orange = c"cb4b16"
solarized.red = c"dc322f"
solarized.magenta = c"d33682"
solarized.violet = c"6c71c4"
solarized.blue = c"268bd2"
solarized.cyan = c"2aa198"
solarized.green = c"859900"

solarized.title = solarized.cyan

solarized.option = solarized.blue
solarized.selected = ANSI.bold .. solarized.option
solarized.checkbox = solarized.base0
solarized.char = solarized.violet

solarized.selector = solarized.red

solarized.default = solarized.base0
solarized.paren = solarized.base0
solarized.sep = solarized.base0

return solarized
