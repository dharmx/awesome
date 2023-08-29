local _module_0 = { }
local mute
mute = function() end
_module_0["mute"] = mute
local if_nil
if_nil = function(a, b)
	if a == nil then
		return b
	else
		return a
	end
end
_module_0["if_nil"] = if_nil
local ok_or_nil
ok_or_nil = function(status, ...)
	if not status then
		return
	else
		return ...
	end
end
_module_0["ok_or_nil"] = ok_or_nil
local npcall
npcall = function(fn, ...)
	return ok_or_nil(pcall(fn, ...))
end
_module_0["npcall"] = npcall
local nil_wrap
nil_wrap = function(fn)
	return function(...)
		return npcall(fn, ...)
	end
end
_module_0["nil_wrap"] = nil_wrap
local pack_len
pack_len = function(...)
	return {
		n = select("#", ...),
		...
	}
end
_module_0["pack_len"] = pack_len
local unpack_len
unpack_len = function(t)
	return table.unpack(t, 1, t.n)
end
_module_0["unpack_len"] = unpack_len
return _module_0
