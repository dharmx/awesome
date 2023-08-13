return setmetatable({}, {
  __index = function(_, key)
    return require("core.util." .. key)
  end,
})
