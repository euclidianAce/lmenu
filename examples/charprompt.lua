#!/usr/bin/env lua
local charprompt = require("lmenu.charprompt")

-- default charprompt is a simple yes/no with yes being default
charprompt():setTitle("This is a charprompt")()
-- explicitly this can be written as
charprompt():setTitle("This is a charprompt (2)")
	:add{"y", "Yes"}
	:add{"n", "No"}
	()

-- default options will be capitalized
charprompt{
	title = "This is a charprompt (3)",
	options = {'a','b','c'}
}()
