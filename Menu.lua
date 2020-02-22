
local Menu = {}

function Menu.new(parent)
	local class
	class = {
		new = function(self, tab)
			return setmetatable(tab or {}, class.metamethods)
		end,
		metamethods = {
			__index = function(t, key)
				if not class[key] and parent then
					return parent[key]
				end
				return class[key]
			end,
		},
	}
	return setmetatable(class, {
		__index = parent,
		__call = function(self, ...)
			return class:new(...)
		end
	})
end

return Menu
