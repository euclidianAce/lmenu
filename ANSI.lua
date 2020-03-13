
local ANSI = {}

local CSI = string.char(27) .. "["
ANSI.color = {
	black = CSI .. "30m",
	red = CSI .. "31m",
	green = CSI .. "32m",
	yellow = CSI .. "33m",
	blue = CSI .. "34m",
	magenta = CSI .. "35m",
	cyan = CSI .. "36m",
	white = CSI .. "37m",
	bright = {
		black = CSI .. "90m",
		red = CSI .. "91m",
		green = CSI .. "92m",
		yellow = CSI .. "93m",
		blue = CSI .. "94m",
		magenta = CSI .. "95m",
		cyan = CSI .. "96m",
		white = CSI .. "97m",
	},
}
ANSI.bold = CSI .. "1m"
ANSI.underline = CSI .. "4m"
ANSI.reset = CSI .. "0m"

local s = "%s%d;%d;%d;%d;%dm"
local function hexToRGB(hexStr)
	if string.sub(hexStr, 1, 1) == "#" then
		hexStr = string.sub(hexStr, 2, -1)
	end
	local r = tonumber(string.sub(hexStr, 1, 2), 16)
	local g = tonumber(string.sub(hexStr, 3, 4), 16)
	local b = tonumber(string.sub(hexStr, 5, 6), 16)
	return r, g, b
end

function ANSI.fg(r, g, b)
	if type(r) == "string" then
		r, g, b = hexToRGB(r)
	end
	return s:format(CSI,38,2,r,g,b)
end
function ANSI.bg(r, g, b)
	if type(r) == "string" then
		r, g, b = hexToRGB(r)
	end
	return s:format(CSI,48,2,r,g,b)
end

local cursor = {}
ANSI.cursor = cursor
function cursor.up(n)
	io.write(CSI .. (n or "") .. "A")
end
function cursor.down(n)
	io.write(CSI .. (n or "") .. "B")
end
function cursor.left(n)
	io.write(CSI .. (n or "") .. "C")
end
function cursor.right(n)
	io.write(CSI .. (n or "") .. "D")
end
function cursor.column(n)
	io.write(string.char(27) .. "[" .. n .. "G")
end

function ANSI.clrln()
	io.write(CSI .. "K")
end

return ANSI
