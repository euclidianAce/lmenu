
local utils = {}

function utils.getContent(option)
	return option.content or option[1] or option
end

function utils.getAltContent(option)
	return option.altContent or option[2]
end

function utils.doCallback(option)
	if option.callback then
		if option.callbackArgs then
			return option.callback(table.unpack(option.callbackArgs))
		end
		return option.callback()
	end
	return utils.getContent(option)
end


return utils
