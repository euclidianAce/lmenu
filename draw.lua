
local colorscheme = require("lmenu.colorscheme")
local ANSI = require("lmenu.ANSI")

local function write(csField, text)
	local cs = colorscheme.current
	io.write(cs[csField], text, ANSI.reset)
end

local draw = setmetatable({}, {
	__index = function(_, key) 
		return function(text)
			write(key, text)
		end
	end
})
function draw.nl()
	io.write('\n')
end
function draw.space()
	io.write(' ')
end

return draw
