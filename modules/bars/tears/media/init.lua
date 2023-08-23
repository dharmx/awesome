local M = {}
local Wibox = require("wibox")
local F = require("lib.functional")

function M.slash(options)
  options = F.if_nil(options, {})
  options.symbol = "/"
  return {
    {
      font = assert(options.font, "please supply a font"),
      text = options.symbol,
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