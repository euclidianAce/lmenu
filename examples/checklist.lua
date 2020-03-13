#!/usr/bin/env lua
local checklist = require("lmenu.checklist")

-- checklists are practically the same as lists,
-- except multiple options can be selected
-- (in fact, the checklist class inherits from list,
-- so anything that works for list should work for checklist)

checklist():setTitle("This is a checklist")
	:add("Option 1")
	:add("Option 2")
	:add("Option 3")
	:add{"Option 4", checked = true}
	()

checklist():setTitle("This is another checklist")
	:setOptions{
		"Option 1", 
		{"Option 2", checked = true},
		"Option 3",
	}
	:setSelected(3)
	()

checklist{
	title = "This is a checklist too",
	options = {
		"Option 1",
		{"Option 2", callback = print},
		{"Option 3", 
		callback = function(a,b)
			return a .. b
		end,
		callbackArgs = {"a", "b"}}
	},
	selected = 2,
}()

