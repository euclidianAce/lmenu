#!/usr/bin/env lua
local list = require("lmenu.list")

list():setTitle("This is a list")
	:add("Option 1")
	:add("Option 2")
	:add("Option 3")
	()

list{
	title = "This is also a list, but it defaults to option 2",
	options = {
		"The first option",
		"Option number 2",
		"3 :)"
	},
	selected = 2,
}()

local result
result = list():setTitle("This is a list where options have callbacks")
	:add("A", function() return 1 end)
	:add("B", print, "Hello, World!")
	:add("C", function(a, b, c) return a+b+c end, 1,2,3)
	()
print("Result of callback: " .. tostring(result))

result = list{
	title = "This is the same list again, but constructed with a table",
	options = {
		{"A",
		callback = function()
			return 1
		end},
		{"B",
		callback = print,
		callbackArgs = {"Hello, World!"}
		},
		{"C",
		callback = function(a,b,c)
			return a+b+c
		end,
		callbackArgs = {1,2,3}
		},
	}
}()
print("Result of callback: " .. tostring(result))
