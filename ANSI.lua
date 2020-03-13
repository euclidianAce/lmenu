
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
---Moves the cursor up n rows
---@param n number
function cursor.up(n)
	io.write(CSI .. (n or "") .. "A")
end
---Moves the cursor down n rows
---@param n number
function cursor.down(n)
	io.write(CSI .. (n or "") .. "B")
end
---Moves the cursor left n columns
---@param n number
function cursor.left(n)
	io.write(CSI .. (n or "") .. "C")
end
---Moves the cursor right n columns
---@param n number
function cursor.right(n)
	io.write(CSI .. (n or "") .. "D")
end
---Sets the cursor's position to column n
---@param n number
function cursor.column(n)
	io.write(CSI .. (n or "") .. "G")
end

---Clears the current line
---@param n number
---	0 or missing: clear from cursor to end of line;
---	1: cursor to beginning of line;
---	2: clear entire line
function ANSI.clrln(n)
	io.write(CSI .. (n or 0) .. "K")
end

return ANSI
