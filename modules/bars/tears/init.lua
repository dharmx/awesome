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
    reverse = true,
    screen = local_screen,
    height = DPI(25),
    width = DPI(90),
    x = DPI(1825),
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
          {
            M.regulate({
              background = Beautiful.taglist_regulate_bg,
              increase = {
                image = Resource.plus_circle_fill,
                stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_regulate_increase_bg),
                callback = function()
                  Awful.tag.add(tostring(#root.tags() + 1), { screen = local_screen })
                end,
              },
              decrease = {
                image = Resource.minus_circle_fill,
                stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_regulate_decrease_bg),
                callback = function()
                  local tags = root.tags()
                  tags[#tags]:delete()
                end,
              },
            }),
            top = DPI(5),
            bottom = DPI(5),
            widget = Wibox.container.margin,
          },
          {
            M.media.slash({
              font = "Dosis 15",
              foreground = Beautiful.wibar_right_separator_fg,
            }),
            left = DPI(10),
            right = DPI(10),
            layout = Wibox.container.margin,
          },
          Awful.widget.taglist(M.tags(local_screen)),
          layout = Wibox.layout.fixed.horizontal,
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
                      right = DPI(5),
                      widget = Wibox.container.margin,
                    },
                    M.monitors.ram(),
                    layout = Wibox.layout.fixed.horizontal,
                  },
                  top = DPI(5),
                  bottom = DPI(5),
                  layout = Wibox.container.margin,
                },
                M.media.slash({
                  font = "Dosis 15",
                  foreground = Beautiful.wibar_right_separator_fg,
                }),
                M.media.dropdown({
                  background = Beautiful.wibar_right_dropdown_bg,
                  icon = {
                    resource = Resource.flag_banner_duotone,
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
                    resource = Resource.caret_double_down_duotone,
                    stylesheet = string.format("*{fill:%s;}", Beautiful.wibar_right_dropdown_collapse_stroke),
                    forced_width = DPI(20),
                  },
                  signal = {
                    on_enter = function(self, _) self:set_bg(Beautiful.wibar_right_dropdown_on_enter_bg) end,
                    on_leave = function(self, _) self:set_bg(Beautiful.wibar_right_dropdown_on_leave_bg) end,
                  },
                }),
                M.media.slash({
                  font = "Dosis 15",
                  foreground = Beautiful.wibar_right_separator_fg,
                }),
                M.media.detached_button({
                  label = {
                    text = "Essentials",
                    font = "Dosis Bold 12",
                  },
                  icon = {
                    resource = Resource.list_light,
                    background = Beautiful.wibar_right_detached_button_icon_bg,
                    stylesheet = string.format("*{fill:%s;}", Beautiful.wibar_right_detached_button_icon_stroke),
                  },
                  signal = {
                    on_enter = function(self, _) self:set_bg(Beautiful.wibar_right_detached_button_signal_on_enter) end,
                    on_leave = function(self, _) self:set_bg(Beautiful.wibar_right_detached_button_signal_on_leave) end,
                  },
                }),
                M.media.slash({
                  font = "Dosis 15",
                  foreground = Beautiful.wibar_right_separator_fg,
                }),
                {
                  M.profile.time({
                    format = string.format(
                      "<span font_desc=%q foreground=%q>%%H</span> <span font_desc=%q foreground=%q>%%M</span>",
                      "Dosis Bold 15", Beautiful.wibar_left_time_hour_fg,
                      "Dosis Bold 15", Beautiful.wibar_left_time_minute_fg
                    ),
                  }),
                  layout = Wibox.container.margin,
                },
                homogeneous = false,
                spacing = DPI(10),
                layout = Wibox.layout.grid.horizontal,
              },
              left = DPI(10),
              right = DPI(12),
              top = DPI(5),
              bottom = DPI(5),
              layout = Wibox.container.margin,
            },
            shape = function(context, width, height) Gears.shape.rounded_rect(context, width, height, DPI(25)) end,
            bg = Beautiful.wibar_right_bg,
            widget = Wibox.container.background,
          },
          {
            M.media.slash({
              font = "Dosis 15",
              foreground = Beautiful.wibar_profile_separator_fg,
              symbol = "│",
            }),
            left = DPI(15),
            right = DPI(12),
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
      left = DPI(30),
      right = DPI(30),
      top = DPI(10),
      bottom = DPI(10),
      layout = Wibox.container.margin,
    },
  }
end

return M
