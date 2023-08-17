local M = {}

local Awful = require("awful")
local Wibox = require("wibox")
local Beautiful = require("beautiful")
local Naughty = require("naughty")
local DPI = require("beautiful.xresources").apply_dpi
local Gears = require("gears")

local buttons = require("core.util.buttons")
local enum = require("core.enum")
local SUPER = enum.modifiers.SUPER

M._instances = {}

M.screenshot = setmetatable({}, {
  __call = function()
    if not M._instances.screenshot then
      M._instances.screenshot = Awful.popup({
        maximum_height = DPI(150),
        minimum_height = DPI(100),
        placement = Awful.placement.centered,
        visible = false,
        ontop = true,
        bg = Beautiful.normal,
        shape = function(context, width, height)
          Gears.shape.rounded_rect(context, width, height, 20)
        end,
        id = "screenshot",
        type = "desktop",
        widget = {
          {
            buttons.smooth_button("custom-hourglass", function()
              Naughty.notification({ title = "Debug", message = "Hello" })
            end),
            left = DPI(20),
            right = DPI(20),
            top = DPI(20),
            bottom = DPI(20),
            widget = Wibox.container.margin,
          },
          {
            buttons.smooth_button("custom-screenshot", function()
              Naughty.notification({ title = "Debug", message = "Hello" })
            end),
            left = DPI(20),
            right = DPI(20),
            top = DPI(20),
            bottom = DPI(20),
            widget = Wibox.container.margin,
          },
          {
            buttons.smooth_button("custom-clock", function()
              Naughty.notification({ title = "Debug", message = "Hello" })
            end),
            left = DPI(20),
            right = DPI(20),
            top = DPI(20),
            bottom = DPI(20),
            widget = Wibox.container.margin,
          },
          layout = Wibox.layout.flex.horizontal,
        },
      })
    end

    local popup = M._instances.screenshot
    popup.visible = not popup.visible
    if popup.visible then
      Awful.keygrabber({
        keybindings = {
          Awful.key({
            modifiers = SUPER,
            key = "k",
            on_press = function() end,
          }),
          Awful.key({
            modifiers = SUPER,
            key = "j",
            on_press = function() end,
          }),
        },
        stop_key = "Escape",
        stop_event = "press",
        stop_callback = function() popup.visible = false end,
        export_keybindings = true,
      })
    end
  end,
})

function M.screenshot.saved(options)
  local screenshot = Awful.screenshot(options)
  local function notify(self)
    Naughty.notification({
      title = self.file_name,
      message = "Screenshot saved",
      icon = self.surface,
      icon_size = 128,
    })
  end
  if options.auto_save_delay > 0 then
    screenshot:connect_signal("file::saved", notify)
  else
    notify(screenshot)
  end
  return screenshot
end

function M.screenshot.delayed(options)
  local screenshot = M.screenshot.saved(options)
  local notification = Naughty.notification({
    title = "Screenshot in:",
    message = tostring(options.auto_save_delay) .. " seconds",
  })
  screenshot:connect_signal(
    "timer::tick",
    function(_, remain) notification.message = tostring(remain) .. " seconds" end
  )
  screenshot:connect_signal("timer::timeout", function()
    if notification then notification:destroy() end
  end)
  return screenshot
end

return M
