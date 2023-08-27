---@diagnostic disable: undefined-field, param-type-mismatch
local M = {}
setmetatable(M, {
  __index = function(_, key) return require("modules.bars.tears." .. key) end,
})

local Wibox = require("wibox")
local Gears = require("gears")
local Awful = require("awful")
local Beautiful = require("beautiful")
local Resource = require("core.utils.factory").resource_factory()

local DPI = require("beautiful.xresources").apply_dpi

function M.tray(local_screen)
  awesome.register_xproperty("WM_NAME", "string")
  local tray = Wibox({
    visible = true,
    screen = local_screen,
    height = DPI(30),
    width = DPI(90),
    x = DPI(1920 - 95),
    y = DPI(1030),
    bg = Beautiful.bg_systray,
    widget = Wibox.widget.systray,
  })
  tray:set_xproperty("WM_NAME", "systray")
end

function M.initialize(local_screen)
  return {
    position = "top",
    screen = local_screen,
    height = DPI(70),
    bg = Beautiful.wibar_bg,
    widget = {
      {
        {
          Awful.widget.taglist(M.workspace(local_screen)),
          top = DPI(10),
          bottom = DPI(10),
          widget = Wibox.container.margin,
        },
        nil,
        {
          {
            {
              {
                {
                  {
                    {
                      M.monitors.cpu(),
                      right = DPI(3),
                      widget = Wibox.container.margin,
                    },
                    {
                      M.monitors.ram(),
                      widget = Wibox.container.margin,
                    },
                    layout = Wibox.layout.fixed.horizontal,
                  },
                  left = DPI(4),
                  top = DPI(5),
                  bottom = DPI(5),
                  right = DPI(5),
                  layout = Wibox.container.margin,
                },
                {
                  M.media.slash({
                    font = "Dosis 15",
                    foreground = Beautiful.wibar_right_separator_fg,
                  }),
                  left = DPI(8),
                  right = DPI(8),
                  layout = Wibox.container.margin,
                },
                {
                  M.media.dropdown({
                    icon = {
                      resource = Resource.flag_banner,
                      stylesheet = string.format("*{fill:%s;}", Beautiful.wibar_right_dropdown_icon_stroke),
                      background = Beautiful.wibar_right_dropdown_icon_bg,
                      foreground = Beautiful.wibar_right_dropdown_icon_fg,
                      outline = Beautiful.wibar_right_dropdown_icon_outline,
                      forced_width = DPI(20),
                    },
                    label = {
                      font = "Dosis 12",
                      text = "Quick Navigation",
                      foreground = Beautiful.wibar_right_dropdown_label_fg,
                    },
                    collapse = {
                      resource = Resource.caret_double_down,
                      stylesheet = string.format("*{fill:%s;}", Beautiful.wibar_right_dropdown_collapse_stroke),
                      forced_width = DPI(20),
                    },
                    signal = {
                      on_enter = function(self, _) self:set_bg(Beautiful.wibar_right_dropdown_on_enter_bg) end,
                      on_leave = function(self, _) self:set_bg(Beautiful.wibar_right_dropdown_on_leave_bg) end,
                    },
                  }),
                  left = DPI(5),
                  layout = Wibox.container.margin,
                },
                {
                  M.media.slash({
                    font = "Dosis 15",
                    foreground = Beautiful.wibar_right_separator_fg,
                  }),
                  left = DPI(8),
                  right = DPI(8),
                  layout = Wibox.container.margin,
                },
                {
                  M.media.detached_button({
                    label = {
                      text = "Essentials",
                      font = "Dosis Bold 12",
                    },
                    icon = {
                      resource = Resource.bookmark_simple,
                      background = Beautiful.wibar_right_detached_button_icon_bg,
                      stylesheet = string.format("*{fill:%s;}", Beautiful.wibar_right_detached_button_icon_stroke),
                    },
                    signal = {
                      on_enter = function(self, _) self:set_bg(Beautiful.wibar_right_detached_button_signal_on_enter) end,
                      on_leave = function(self, _) self:set_bg(Beautiful.wibar_right_detached_button_signal_on_leave) end,
                    },
                  }),
                  left = DPI(5),
                  right = DPI(8),
                  layout = Wibox.container.margin,
                },
                homogeneous = false,
                layout = Wibox.layout.grid.horizontal,
              },
              margins = DPI(5),
              layout = Wibox.container.margin,
            },
            bg = Beautiful.wibar_right_bg,
            shape = function(context, width, height) Gears.shape.rounded_rect(context, width, height, DPI(25)) end,
            widget = Wibox.container.background,
          },
          {
            M.media.slash({
              font = "Dosis 15",
              foreground = Beautiful.wibar_profile_separator_fg,
              symbol = "│",
            }),
            left = DPI(8),
            right = DPI(7),
            layout = Wibox.container.margin,
          },
          {
            M.profile.logo({
              image = Beautiful.logo,
              border_width = DPI(1),
              border_color = Beautiful.logo_border_color,
            }),
            top = DPI(3),
            bottom = DPI(3),
            widget = Wibox.container.margin,
          },
          layout = Wibox.layout.fixed.horizontal,
        },
        layout = Wibox.layout.align.horizontal,
      },
      margins = DPI(10),
      layout = Wibox.container.margin,
    },
  }
end

return M
