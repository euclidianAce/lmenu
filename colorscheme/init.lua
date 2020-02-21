
local colorscheme = {}

colorscheme.current = require("lmenu.colorscheme.default")
function colorscheme.load(name)
	local ok, cs = pcall(require, "lmenu.colorscheme." .. name)
	if not ok then
		error("Unable to load colorscheme " .. name .. "\n" .. cs, 2)
	end
	colorscheme.current = cs
end

return colorscheme
