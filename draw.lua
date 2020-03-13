
local colorscheme = require("lmenu.colorscheme")
local ANSI = require("lmenu.ANSI")
local utils = require("lmenu.utils")

local function write(csField, object)
	local cs = colorscheme.current
	if type(object) == "table" then
		io.write(object.color or cs[csField])
	else
		io.write(cs[csField])
	end
	io.write(utils.getContent(object))
	io.write(ANSI.reset)
end

local draw = setmetatable({}, {
	__index = function(_, key) 
		return function(object)
			write(key, object)
		end
	end
})
function draw.nl()
	io.write('\n')
end
function draw.space(n)
	n = n or 1
	io.write((' '):rep(n))
end

return draw
