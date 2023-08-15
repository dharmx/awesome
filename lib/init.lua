---Ported and self-made libraries.
---@type Lib
local module = setmetatable({}, {
  __index = function(_, key)
    return require("lib." .. key)
  end,
})

return module
