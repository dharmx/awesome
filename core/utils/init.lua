---AwesomeWM-centric utilities.
return setmetatable({}, {
  __index = function(_, key)
    return require("core.utils." .. key)
  end,
})
