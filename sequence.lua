
local sequence = {}
sequence.__index = sequence
function sequence.new()
	return setmetatable({menus = {}}, sequence)
end

function sequence:add(title, menu)
	table.insert(self.menus, {
		title = title,
		menu = menu,
	})
	return self
end

local function iterate(sequence)
	for i, menu in ipairs(sequence.menus) do
		io.write(menu.title)
		io.write("\n")
		coroutine.yield(menu.menu())
	end
end
function sequence:__call()
	for i, menu in ipairs(self.menus) do
		if menu.title ~= "" then
			io.write(menu.title)
			io.write("\n")
		end
		menu.menu()
	end
end
function sequence:iterate()
	return coroutine.wrap(iterate), self
end


return sequence
