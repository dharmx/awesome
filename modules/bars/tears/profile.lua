local M = {}

local Wibox = require("wibox")
local DPI = require("beautiful.xresources").apply_dpi
local Gears = require("gears")
local widgets = require("core.components.widgets")

function M.logo(options)
  options = if_nil(options, {})
  options.clip_shape = if_nil(options.clip_shape, Gears.shape.circle)
  assert(options.image, "please supply a 1x1 image")
  return {
    {
      {
        image = options.image,
        forced_height = options.forced_height,
        forced_width = options.forced_width,
        clip_shape = options.clip_shape,
        widget = Wibox.widget.imagebox,
      },
      margins = DPI(2),
      widget = Wibox.container.margin,
    },
    border_width = options.border_width,
    border_color = options.border_color,
    shape = options.clip_shape,
    widget = Wibox.container.background,
  }
end

function M.time(options)
  options = if_nil(options, {})
  options.interval = if_nil(options.interval, 1)
  options.format = if_nil(options.format, "%X")

  local datebox = Wibox.widget.textbox()
  datebox.font = if_nil(options.font, "Dosis 15")
  datebox.valign = "center"
  return widgets.polls.callback(function(widget)
    widget:set_markup(os.date(options.format))
  end, options.interval, datebox)
end

return M
