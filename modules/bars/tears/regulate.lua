local M = {}

local Wibox = require("wibox")
local Gears = require("gears")
local T = require("lib.tiny")
local DPI = require("beautiful.xresources").apply_dpi

function M.new(options)
  options = if_nil(options, {})
  options.increase = if_nil(options.increase, {})
  options.decrease = if_nil(options.decrease, {})

  local increase = Wibox.widget.imagebox(options.increase.image)
  increase.stylesheet = options.increase.stylesheet
  if options.increase.callback then
    increase:connect_signal("button::press", options.increase.callback)
  end

  local decrease = Wibox.widget.imagebox(options.decrease.image)
  decrease.stylesheet = options.decrease.stylesheet
  if options.decrease.callback then
    decrease:connect_signal("button::press", options.decrease.callback)
  end

  return {
    {
      {
        decrease,
        increase,
        layout = Wibox.layout.fixed.horizontal,
      },
      margins = DPI(5),
      widget = Wibox.container.margin,
    },
    shape = function(context, width, height) Gears.shape.rounded_rect(context, width, height, DPI(25)) end,
    bg = options.background,
    widget = Wibox.container.background,
  }
end

setmetatable(M, {
  __call = function(self, options)
    return self.new(options)
  end,
})
return M
