local M = {}
local Wibox = require("wibox")
local Gears = require("gears")
local DPI = require("beautiful.xresources").apply_dpi

function M.new(options)
  options = if_nil(options, {})
  options.label = if_nil(options.label, {})
  options.icon = if_nil(options.icon, {})
  options.signal = if_nil(options.signal, {})

  local iconbox = Wibox.container.background()
  if options.signal.on_press then iconbox:connect_signal("button::press", options.signal.on_press) end
  iconbox:connect_signal("mouse::enter", options.signal.on_enter)
  iconbox:connect_signal("mouse::leave", options.signal.on_leave)

  return {
    {
      {
        {
          {
            image = assert(options.icon.resource, "please supply a icon.resource"),
            valign = "center",
            halign = "center",
            forced_width = DPI(20),
            stylesheet = assert(options.icon.stylesheet, "please supply a icon.stylesheet"),
            widget = Wibox.widget.imagebox,
          },
          right = DPI(7),
          left = DPI(7),
          top = DPI(3),
          bottom = DPI(3),
          widget = Wibox.container.margin,
        },
        valign = "center",
        halign = "center",
        shape = Gears.shape.rounded_rect,
        bg = assert(options.icon.background, "please supply a icon.background"),
        widget = iconbox,
      },
      right = DPI(5),
      top = DPI(3),
      bottom = DPI(3),
      widget = Wibox.container.margin,
    },
    {
      {
        text = assert(options.label.text, "please supply a label.text"),
        font = assert(options.label.font, "please supply a label.font"),
        widget = Wibox.widget.textbox,
      },
      bottom = DPI(2),
      widget = Wibox.container.margin,
    },
    layout = Wibox.layout.fixed.horizontal,
  }
end

setmetatable(M, { __call = function(self, options) return self.new(options) end })
return M
