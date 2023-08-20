---@diagnostic disable: missing-parameter
local M = {}

local U = require("lib.std")
local F = require("lib.functional")
local DPI = require("beautiful.xresources").apply_dpi
local Resource = require("core.utils.factory").resource_factory()

local Awful = require("awful")
local Gears = require("gears")
local Wibox = require("wibox")

function M.slash(colors, options)
  options = U.table.deep_extend("keep", F.if_nil(options, {}), {
    symbol = "/",
    font = "Dosis 15",
    foreground = colors.white:darken(30):to_hex(true),
  })

  return {
    {
      font = options.font,
      text = options.symbol,
      widget = Wibox.widget.textbox,
    },
    fg = options.foreground,
    widget = Wibox.container.background,
  }
end

function M.radial(colors, options)
  options = U.table.deep_extend("keep", F.if_nil(options, {}), {
    value = 0.6,
    background = colors.bblack:lighten(7):to_hex(true),
    radial_background = colors.bblack:lighten(12):to_hex(true),
    radial_foreground = colors.blue:to_hex(true),
    radial_body_background = colors.bblack:lighten(14):to_hex(true),
    thickness = DPI(5),
    interval = 2,
    max_value = 1,
    min_value = 0,
  })

  local arcchart = Wibox.container.arcchart({
    bg = options.radial_body_background,
    widget = Wibox.container.background,
  })

  arcchart.max_value = options.max_value
  arcchart.min_value = options.max_value
  arcchart.bg = options.background
  arcchart.forced_width = DPI(33)
  arcchart.value = options.value
  arcchart.colors = { options.radial_foreground }
  arcchart.rounded_edge = true
  arcchart.border_color = options.radial_background
  arcchart.thickness = options.thickness
  arcchart.paddings = options.paddings
  return Awful.widget.watch(options.command, options.interval, options.update, arcchart)
end

function M.dropdown(colors, options)
  options = U.table.deep_extend("keep", F.if_nil(options, {}), {
    icon = {
      symbol = Resource.flag_banner,
      stylesheet = string.format("*{fill:#%s;}", colors.bblack:lighten(40):to_hex()),
      background = colors.green:to_hex(true),
      foreground = colors.bblack:lighten(10):to_hex(true),
      outline = colors.bblack:lighten(20):to_hex(true),
    },
    label = {
      font = "Dosis 12",
      text = "Browse Harpoons",
      foreground = colors.white:to_hex(true),
    },
    downward_icon = {
      image = Resource.caret_down,
      stylesheet = string.format("*{fill:#%s;}", colors.bblack:lighten(40):to_hex()),
    },
    signals = {
      dropdown = {
        on_enter = function(self, _)
          self:set_bg(colors.black:lighten(2):brighten(6):to_hex(true))
        end,
        on_leave = function(self, _)
          self:set_bg(colors.black:lighten(2):to_hex(true))
        end,
      }
    },
  })

  local dropdown = Wibox.container.background(nil, nil, function(context, width, height)
    Gears.shape.rounded_rect(context, width, height, DPI(20))
  end)
  if options.on_press then
    dropdown:connect_signal("button::press", options.signals.dropdown.on_press)
  end
  dropdown:connect_signal("mouse::enter", options.signals.dropdown.on_enter)
  dropdown:connect_signal("mouse::leave", options.signals.dropdown.on_leave)
  return {
    {
      {
        {
          {
            {
              {
                image = options.icon.symbol,
                halign = "center",
                valign = "center",
                forced_width = DPI(20),
                widget = Wibox.widget.imagebox,
              },
              bottom = DPI(8),
              top = DPI(8),
              left = DPI(8),
              right = DPI(8),
              widget = Wibox.container.margin,
            },
            shape = Gears.shape.circle,
            bg = options.icon.background,
            fg = options.icon.foreground,
            border_width = DPI(2),
            border_color = options.icon.outline,
            widget = Wibox.container.background,
          },
          right = DPI(5),
          left = DPI(3),
          widget = Wibox.container.margin,
        },
        {
          {
            {
              text = options.label.text,
              halign = "center",
              valign = "center",
              font = options.label.font,
              widget = Wibox.widget.textbox,
            },
            fg = options.label.foreground,
            widget = Wibox.container.background,
          },
          right = DPI(3),
          bottom = DPI(2),
          widget = Wibox.container.margin,
        },
        {
          {
            image = options.downward_icon.image,
            stylesheet = options.downward_icon.stylesheet,
            forced_width = DPI(20),
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

function M.detached_button(colors, options)
  options = U.table.deep_extend("keep", F.if_nil(options, {}), {
    icon = Resource.bookmark_simple,
    icon_background = colors.bblack:lighten(10):to_hex(true),
    label = "Bookmarks",
    label_font = "Dosis Bold 12",
    icon_stylesheet = string.format("*{fill:#%s;}", colors.white:darken(10):to_hex()),
    signals = {
      on_enter = function(self, _)
        self:set_bg(colors.black:lighten(10):brighten(10):to_hex(true))
      end,
      on_leave = function(self, _)
        self:set_bg(colors.bblack:lighten(10):to_hex(true))
      end,
    },
  })

  local iconbox = Wibox.container.background()
  if options.signals.on_press then
    iconbox:connect_signal("button::press", options.signals.on_press)
  end
  iconbox:connect_signal("mouse::enter", options.signals.on_enter)
  iconbox:connect_signal("mouse::leave", options.signals.on_leave)

  return {
    {
      {
        {
          {
            {
              image = options.icon,
              valign = "center",
              halign = "center",
              forced_width = DPI(20),
              stylesheet = options.icon_stylesheet,
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
          bg = options.icon_background,
          widget = iconbox,
        },
        right = DPI(6),
        widget = Wibox.container.margin,
      },
      {
        text = options.label,
        font = options.label_font,
        widget = Wibox.widget.textbox,
      },
      layout = Wibox.layout.fixed.horizontal,
    },
    top = DPI(3),
    bottom = DPI(3),
    widget = Wibox.container.margin,
  }
end

return M
