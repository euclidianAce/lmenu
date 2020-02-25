#!/usr/bin/env lua
local prompt = require("lmenu.prompt")

local result
result = prompt()
		:setTitle("Hello")
		:setDefault("things")()

print("Result from prompt: " .. tostring(result))

result = prompt{
	title = "Hello again",
	default = "Stuff"
}()
print("Result from prompt: " .. tostring(result))


result = prompt{
	title = "Hello again",
	default = "Stuff",
	callback = print, -- prompts use their inputs for their callback's first argument
}()
-- but more arguments can be given with the same callbackArgs field

result = prompt{
	title = "Hello again",
	default = "Stuff",
	callback = print,
	callbackArgs = {" <- that was the result of the prompt. :)"}
}()
