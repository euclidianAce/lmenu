
local ANSI = require("lmenu.ANSI")
local c = ANSI.fg

-- from https://github.com/dracula/dracula-theme

local drac = setmetatable({}, {
	__index = function(self)
		return self.foreground
	end
})

drac.background = c("#282a36")
drac.currentline = c("#44475a")
drac.selection = c("44475a")
drac.foreground = c("#f8f8f2")
drac.comment = c("#6272a4")
drac.cyan = c("#8be9fd")
drac.green = c("#50fa7b")
drac.orange = c("#ffb86c")
drac.pink = c("#ff79c6")
drac.purple = c("#bd93f9")
drac.red = c("#ff5555")
drac.yellow = c("#f1fa8c")

drac.title = drac.foreground

drac.option = drac.purple
drac.selected = ANSI.bold .. drac.option
drac.checkbox = drac.pink
drac.char = drac.green

drac.selector = drac.yellow

drac.default = drac.green
drac.paren = drac.comment
drac.sep = drac.comment

return drac
