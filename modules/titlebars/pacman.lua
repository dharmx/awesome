local M = {}

local Awful = require("awful")
local Wibox = require("wibox")
local Beautiful = require("beautiful")
local DPI = Beautiful.xresources.apply_dpi

local buttons = require("core.components.buttons")
local enum = require("core.enum")
local EMPTY = enum.modifiers.EMPTY

M.buttons = map(Awful.button, {
  {
    modifiers = EMPTY,
    button = 1,
    on_press = function(node)
      if not node.activate then return end
      node:activate({ context = "titlebar", action = "mouse_move" })
    end,
  },
  {
    modifiers = EMPTY,
    button = 3,
    on_press = function(node)
      if not node.activate then return end
      node:activate({ context = "titlebar", action = "mouse_resize" })
    end,
  },
})

function M.top(node)
  return {
    {
      {
        Awful.titlebar.widget.iconwidget(node),
        top = DPI(14),
        bottom = DPI(14),
        left = DPI(13),
        widget = Wibox.container.margin,
      },
      {
        Awful.titlebar.widget.titlewidget(node),
        top = DPI(10),
        bottom = DPI(10),
        widget = Wibox.container.margin,
      },
      buttons = M.buttons,
      layout = Wibox.layout.fixed.horizontal,
    },
    {
      buttons = M.buttons,
      layout = Wibox.layout.flex.horizontal,
    },
    {
      {
        buttons.methman.minimize(node, 15, Beautiful.titlebar_pacman_minimize),
        widget = Wibox.container.margin,
        top = DPI(14),
        bottom = DPI(14),
        left = DPI(5),
        right = DPI(2),
      },
      {
        buttons.methman.maximize(node, 15, Beautiful.titlebar_pacman_maximize),
        top = DPI(14),
        bottom = DPI(14),
        left = DPI(5),
        right = DPI(2),
        widget = Wibox.container.margin,
      },
      {
        buttons.methman.close(node, 15, Beautiful.titlebar_pacman_close),
        top = DPI(14),
        bottom = DPI(14),
        left = DPI(5),
        right = DPI(13),
        widget = Wibox.container.margin,
      },
      layout = Wibox.layout.fixed.horizontal,
    },
    layout = Wibox.layout.align.horizontal,
  }
end

return M
