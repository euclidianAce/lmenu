
local getchar = require("lgetchar").getchar

local _, path = ...
path = path:sub(1, -9)


local lmenu
do
	local oldpath = package.path
	package.path = path .. "?.lua"
	lmenu = {
		list = require("list"),
		sequence = require("sequence"),
		prompt = require("prompt"),
	}
	package.path = oldpath
end


return lmenu
