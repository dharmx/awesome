local M = {}

---@overload fun(): table
---@overload fun(background: string): table
---@overload fun(colors: string, background: string): table
function M.get(colors, background)
  if not colors and not background then
    local config = require("core.config").get()
    background = config.background
    colors = config.colors
  elseif colors and not background then
    local config = require("core.config").get()
    background = colors
    colors = config.colors
  end
  return require("colors." .. colors).background[background]
end

setmetatable(M, {
  __call = function(self, ...)
    return self.get(...)
  end,
  __index = function(self, ...)
    return self:__call(...)
  end,
})

return M
