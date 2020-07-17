# This is currently broken (sort of)

I've been refactoring some of my libraries in addition to rewriting them in [Teal](https://github.com/teal-language/tl), and this ones dependency, lgetchar, has gone through a (much needed) rewrite, but is now completely incompatible. Additionally, this module uses a class model that the current type system in Teal doesn't play well with, so ¯\\\_(ツ)\_/¯

but if you use the non `--dev` version of `lgetchar` this may work fine, but just know in the future there will probably be a rewrite
# lmenu
A simple library for creating command line menus, inspired by inquirer.js.

![](images/listexample.svg)
![](images/allexample.svg)

# Dependencies
 - \>= Lua 5.1
 - lgetchar\*

\* This uses my [lgetchar](https://github.com/3uclidian/lgetchar) library, (which is cobbled together and as it says on its own repo I have no idea how portable it is) to allow for arrow keys and such to be recognized

# Usage
Create a menu object, add options to it with callbacks, then call the menu

```lua
local lmenu = require "lmenu"
local m = lmenu.list()
m:setSelector("->")
m:add("This is an option")
m:add("Option 2")
m:add(":)")
m()
```
Or for convenience, each function will return the menu object so you can chain them together like so:
```lua
local m = lmenu.list()
	:setSelector("->")
	:add("This is an option")
	:add("Option 2")
	:add(":)")
	()
```

Which should produce the following menu, controlled by the arrow keys (or j and k for vim users) and enter
```
->This is an option
  Option 2
  :)
```

----
More examples can be found in the examples directory of this repository and in the project and update scripts in my [utils repository](https://github.com/3uclidian/utils)


![](images/updateexample.svg)
