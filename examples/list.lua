#!/usr/bin/env lua
local list = require("lmenu.list")

list():setTitle("This is a list")
	:add("Option 1")
	:add("Option 2")
	:add("Option 3")
	()

list{
	title = "This is also a list, but differently constructed",
	options = {
		"Option 1",
		"Option 2",
		"Option 3"
	},
	selected = 2,
}()

local result
result = list():setTitle("This is a list where options have callbacks")
	:add("Option 1", function() return 1 end)
	:add("Option 2", print, "Hello, World!")
	:add("Option 3", function(a, b, c) return a+b+c end, 1,2,3)
	()
print("Result of callback: " .. tostring(result))

result = list{
	title = "This is the same list again",
	options = {
		{"Option 1",
		callback = function()
			return 1
		end},
		{"Option 2",
		callback = print,
		callbackArgs = {"Hello, World!"}
		},
		{"Option 3",
		callback = function(a,b,c)
			return a+b+c
		end,
		callbackArgs = {1,2,3}
		},
	}
}()
print("Result of callback: " .. tostring(result))
