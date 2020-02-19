# lmenu
A simple library for creating command line menus, inspired by inquirer.js.

# Dependencies
 - Lua 5.3
 - lgetchar\*

\* This uses my lgetchar library, (which is cobbled together and as it says on its own repo
I have no idea how portabe it is) to allow for arrow keys and such to be recognized



# Usage
Create a menu object, add options to it with callbacks, then call the menu

```lua
local lmenu = require "lmenu"
local m = lmenu.new("->")
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
Which should produce the following menu, controlled by the arrow keys and enter
```
->This is an option
  Option 2
  :)
```
