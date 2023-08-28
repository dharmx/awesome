---@diagnostic disable: unused-local, undefined-field
local Awful = require("awful")
local UPowerGlib = require("lgi").require("UPowerGlib")
local Battery = require("lib.battery")
require("awful.autofocus")

local config = require("core.config").get()
local theme = require("modules.bars." .. config.modules.bars_theme)

-- let us all worship Javacafe.
if UPowerGlib.Client():get_devices() then
  Battery({
    instant_update = true,
    device_path = "/org/freedesktop/UPower/devices/battery_BAT0",
  }):connect_signal("upower::update", function(_, device)
    local time_to_empty = device.time_to_empty / 60
    local time_to_full = device.time_to_full / 60
    awesome.emit_signal("signal::battery",
      tonumber(string.format("%.0f", device.percentage)),
      device.state,
      tonumber(string.format("%.0f", time_to_empty)),
      tonumber(string.format("%.0f", time_to_full)),
      device.battery_level
    )
  end)
end

screen.connect_signal("request::desktop_decoration", function(local_screen)
  Awful.tag({ "1", "2", "3", "4", "5" }, local_screen, Awful.layout.layouts[1])
  Awful.wibar(theme.initialize(local_screen))
  theme.tray(local_screen)
end)
