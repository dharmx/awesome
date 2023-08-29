local _module_0 = { }
local before = ...
setmetatable(_module_0, {
	__index = function(_, key)
		return require(before .. "." .. key)
	end
})
return _module_0
