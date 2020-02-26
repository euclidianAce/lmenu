
local Menu = {}

function Menu.new(parent)
	local class
	class = {
		new = function(self, tab)
			return setmetatable(tab or {}, class.metamethods)
		end,
		add = function(self, content, callback, ...)
			if not rawget(self, "options") then
				self.options = {}
			end
			if type(content) == "table" then
				table.insert(self.options, content)
			else
				table.insert(self.options, {
					content = content,
					callback = callback,
					callbackArgs = {...},
				})
			end
			return self
		end,
		metamethods = {
			__index = function(t, key)
            -- auto generate setter functions
            if type(key) == "string" and #key > 3 and key:sub(1,3) == "set" then
               local varName = key:sub(4,4):lower() .. key:sub(5,-1)
               return function(t, val)
                  t[varName] = val
                  return t
               end
            end
            -- inheritence
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
