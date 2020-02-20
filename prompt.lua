
local prompt = {}
prompt.__index = prompt

function prompt.new(question, default, callback)
	return setmetatable({
		question = question,
		default = default,
		callback = callback or function(input) 
			return input
		end,
	}, prompt)
end
function prompt:__call()
	io.write(self.question)
	if self.default then
		io.write(" (", self.default, ")")
	end
	io.write(": ")
	local input = io.read()
	if input == "" then input = self.default end
	return self.callback(input)
end

return prompt
