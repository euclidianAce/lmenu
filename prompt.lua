
local prompt = {}
prompt.__index = prompt

function prompt.new(question, default, callback, ...)
	return setmetatable({
		question = question,
		default = default or "",
		callback = callback or function(input) 
			return input
		end,
		callbackArgs = {},
	}, prompt)
end

function prompt:draw()
	io.write(self.question)
	if self.default ~= "" then
		io.write(" (", self.default, ")")
	end
	io.write(": ")
end

function prompt:__call()
	self:draw()
	local input = io.read()
	if input == "" then input = self.default end
	io.write(string.char(27) .. "[A")
	io.write(string.char(27) .. "[K")
	io.write(self.question, ": ", input, "\n")
	self.callback(input, table.unpack(self.callbackArgs))
	return input
end

return prompt
