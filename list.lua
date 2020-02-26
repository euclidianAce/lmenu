
local Menu = require("lmenu.Menu")
local ANSI = require("lmenu.ANSI")
local draw = require("lmenu.draw")
local lgetchar = require("lgetchar")
local function getkey()
	local c = lgetchar.getChar()
	local d, e
	if c == 27 then
		d = lgetchar.getChar()
		e = lgetchar.getChar()
	end
	return c, d, e
end

local list = Menu.new()
list.selector = " -> "
list.selected = 1
list.options = {}

local function getContent(option)
	return option.content or option[1] or option
end

function list:resetCursor()
	local len = #self.options + (self.title and 1 or 0)
	for i = 1, len do
		ANSI.cursor.up()
		ANSI.clrln()
	end
end

function list:cursorUp()
	self.selected = self.selected - 1
	if self.selected < 1 then
		self.selected = #self.options
	end
end

function list:cursorDown()
	self.selected = self.selected + 1
	if self.selected > #self.options then
		self.selected = 1
	end
end

list.keyhandles = {
	[10] = function() return false end, -- enter
	[106] = function(self) -- j
		self:cursorDown()
		return true
	end,
	[107] = function(self) -- k
		self:cursorUp()
		return true
	end,
	[27] = {
		[91] = {
			[65] = function(self)
				self:cursorUp()
				return true
			end,
			[66] = function(self)
				self:cursorDown()
				return true
			end,
		},
	},
}

function list:handlekeys()
	local kh = self.keyhandles
	for i, v in ipairs{getkey()} do
		kh = kh[v]
		if not kh then
			return true
		end
	end
	return kh(self)
end

function list:draw(sel)
	if sel then
		if self.title then
			draw.title(self.title)
			draw.space()
		end
		local option = getContent(self.options[self.selected])
		draw.selected(option)
		draw.nl()
		return
	end

	if self.title then
		draw.title(self.title)
		draw.nl()
	end
	for i, option in ipairs(self.options) do
		option = getContent(option)
		if i == self.selected then
			draw.selector(self.selector)
			draw.selected(option)
		else
			draw.space(#self.selector)
			draw.option(option)
		end
		draw.nl()
	end
end

function list:run()
	local running = true
	while running do
		self:draw()
		running = self:handlekeys()
		self:resetCursor()
	end
	local selected = self.selected
	local opt = self.options[selected]
	self:draw(true)
	if opt.callback then
		if opt.callbackArgs then
			return opt.callback(table.unpack(opt.callbackArgs))
		end
		return opt.callback()
	end
	return getContent(opt)
end

list.metamethods.__call = list.run

return list
