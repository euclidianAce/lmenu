
local sequence = {}
sequence.__index = sequence
function sequence.new()
	return setmetatable({menus = {}}, sequence)
end

function sequence:add(menu)
	table.insert(self.menus, {
		menu = menu,
	})
	return self
end

local function iterate(sequence)
	for i, menu in ipairs(sequence.menus) do
		coroutine.yield(menu.menu())
	end
end
function sequence:__call()
	local rvals = {}
	for i, menu in ipairs(self.menus) do
		table.insert(rvals, {menu.menu()})
	end
	return rvals
end
function sequence:iterate()
	return coroutine.wrap(iterate), self
end


return sequence
