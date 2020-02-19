
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
function sequence:__call()
	local i = 0
	return function()
		i = i + 1
		if i > #self.menus then
			return
		end
		print(self.menus[i].title)
		return self.menus[i].menu()
	end
end

return sequence
