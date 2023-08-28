local M = {}
local Wibox = require("wibox")

function M.slash(options)
  options = if_nil(options, {})
  return {
    {
      font = if_nil(options.font, "Dosis 15"),
      text = if_nil(options.symbol, "/"),
      valign = "center",
      widget = Wibox.widget.textbox,
    },
    fg = assert(options.foreground, "please supply a foreground"),
    widget = Wibox.container.background,
  }
end

setmetatable(M, {
  __index = function(self, key)
    local widget = rawget(self, key)
    if not widget then return require("modules.bars.tears.media." .. key) end
    return widget
  end,
})
return M
