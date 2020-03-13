#!/usr/bin/env lua
local prompt = require("lmenu.prompt")

local result
result = prompt()
	:setTitle("Hello")
	:setDefault("Hi")()

print("Result from prompt: " .. tostring(result))

result = prompt{
	title = "How are you?",
	default = "Fine"
}()
print("Result from prompt: " .. tostring(result))


result = prompt{
	title = "How are things?",
	default = "Alright",
	callback = print, -- prompts use their inputs for their callback's first argument
}()
-- but more arguments can be given with the same callbackArgs field

result = prompt{
	title = "Okay then",
	default = "Bye",
	callback = print,
	callbackArgs = {" <- that was the result of the prompt. Goodbye :)"}
}()
