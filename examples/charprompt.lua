#!/usr/bin/env lua
local charprompt = require("lmenu.charprompt")

-- default charprompt is a simple yes/no with yes being default
charprompt():setTitle("Yes or no?")()

-- explicitly this can be written as
charprompt():setTitle("Again")
	:add{"y", "Yes"}
	:add{"n", "No"}
	()

-- default options will be capitalized
charprompt{
	title = "Here are some more options",
	options = {'a','b','c'}
}()
