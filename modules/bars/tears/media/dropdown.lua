local M = {}
local Wibox = require("wibox")
local Gears = require("gears")
local F = require("lib.functional")
local DPI = require("beautiful.xresources").apply_dpi

function M.new(options)
  options = F.if_nil(options, {})
  options.icon = F.if_nil(options.icon, {})
  options.label = F.if_nil(options.label, {})
  options.collapse = F.if_nil(options.collapse, {})
  options.signal = F.if_nil(options.signal, {})

  local dropdown = Wibox.container.background(nil, nil, function(context, width, height)
    Gears.shape.rounded_rect(context, width, height, DPI(20))
  end)
  if options.on_press then dropdown:connect_signal("button::press", options.signal.dropdown.on_press) end
  dropdown:connect_signal("mouse::enter", options.signal.dropdown.on_enter)
  dropdown:connect_signal("mouse::leave", options.signal.dropdown.on_leave)
  return {
    {
      {
        {
          {
            {
              {
                image = assert(options.icon.resource, "please supply a icon.resource"),
                halign = "center",
                valign = "center",
                forced_width = options.icon.forced_width,
                forced_height = options.icon.forced_height,
                widget = Wibox.widget.imagebox,
              },
              bottom = DPI(8),
              top = DPI(8),
              left = DPI(8),
              right = DPI(8),
              widget = Wibox.container.margin,
            },
            shape = Gears.shape.circle,
            bg = assert(options.icon.background, "please supply a icon.background"),
            fg = assert(options.icon.foreground, "please supply a icon.foreground"),
            border_width = DPI(2),
            border_color = assert(options.icon.outline, "please supply a icon.outline"),
            widget = Wibox.container.background,
          },
          right = DPI(5),
          left = DPI(3),
          widget = Wibox.container.margin,
        },
        {
          {
            {
              text = assert(options.label.text, "please supply a label.text"),
              halign = "center",
              valign = "center",
              font = assert(options.label.font, "please supply a label.font"),
              widget = Wibox.widget.textbox,
            },
            fg = assert(options.label.foreground, "please supply a label.foreground"),
            widget = Wibox.container.background,
          },
          right = DPI(3),
          bottom = DPI(2),
          widget = Wibox.container.margin,
        },
        {
          {
            image = assert(options.collapse.resource, "please supply a collapse.resource"),
            stylesheet = assert(options.collapse.stylesheet, "please supply a collapse.stylesheet"),
            forced_width = options.collapse.forced_width,
            forced_height = options.collapse.forced_height,
            valign = "center",
            widget = Wibox.widget.imagebox,
          },
          right = DPI(6),
          widget = Wibox.container.margin,
        },
        layout = Wibox.layout.align.horizontal,
      },
      top = DPI(3),
      bottom = DPI(3),
      widget = Wibox.container.margin,
    },
    widget = dropdown,
  }
end

setmetatable(M, {
  __call = function(self, options)
    return self.new(options)
  end,
})
return M
