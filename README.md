# lmenu
A simple library for creating command line menus, inspired by inquirer.js.

# Dependencies
 - Lua 5.3
 - lgetchar\*

\* This uses my lgetchar library, (which is cobbled together and as it says on its own repo I have no idea how portabe it is) to allow for arrow keys and such to be recognized

# Usage
Create a menu object, add options to it with callbacks, then call the menu

```lua
local lmenu = require "lmenu"
local m = lmenu.list.new("->")
m:add("This is an option", function()
	print("Things")
end)
m:add("Option 2", function()
	print("2")
end)
m:add(":)", function()
	print(":(")
end)
m()
```
Or for convenience, the `add` function will return the menu object so you can chain them together like so:
```lua
local m = lmenu.list.new("->")
	:add("This is an option", function()
		print("Things")
	end)
	:add("Option 2", function()
		print("2")
	end)
	:add(":)", function()
		print(":(")
	end)
m()

```

Which should produce the following menu, controlled by the arrow keys and enter
```
->This is an option
  Option 2
  :)
```

# Examples
Right now, I use it in some of my utility scripts for convenient menus.
