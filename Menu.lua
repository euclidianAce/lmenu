
---The base class that all menus inherit from
---@class Menu
---@field new
local Menu = {}

---Creates a new menu class with parent `parent`
---@param parent Menu
function Menu.new(parent)
	local class
	class = {
		new = function(self, tab)
			return setmetatable(tab or {}, class.metamethods)
		end,
		---Create an option for a menu
		---@param content string What shows up
		---@param callback function What gets called when this option is selected
		---@param ...
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
			__call = function(self)
				return self:run()
			end
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
