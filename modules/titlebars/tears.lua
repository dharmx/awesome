local M = {}

local Awful = require("awful")
local Wibox = require("wibox")
local Beautiful = require("beautiful")
local DPI = Beautiful.xresources.apply_dpi

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
        right = DPI(1),
        widget = Wibox.container.margin,
      },
      {
        Awful.titlebar.widget.titlewidget(node),
        top = DPI(10),
        bottom = DPI(10),
        left = DPI(5),
        right = DPI(0),
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
        Awful.titlebar.widget.minimizebutton(node),
        top = DPI(16),
        bottom = DPI(16),
        left = DPI(5),
        right = DPI(2),
        widget = Wibox.container.margin,
      },
      {
        Awful.titlebar.widget.maximizedbutton(node),
        top = DPI(16),
        bottom = DPI(16),
        left = DPI(5),
        right = DPI(2),
        widget = Wibox.container.margin,
      },
      {
        Awful.titlebar.widget.closebutton(node),
        top = DPI(16),
        bottom = DPI(16),
        left = DPI(5),
        right = DPI(15),
        widget = Wibox.container.margin,
      },
      layout = Wibox.layout.fixed.horizontal,
    },
    layout = Wibox.layout.align.horizontal,
  }
end

function M.left(node)
  return {
    {
      {
        Awful.titlebar.widget.iconwidget(node),
        margins = { top = DPI(13), right = DPI(13), left = DPI(13), bottom = DPI(1) },
        widget = Wibox.container.margin,
      },
      buttons = M.buttons,
      layout = Wibox.layout.fixed.vertical,
    },
    {
      buttons = M.buttons,
      layout = Wibox.layout.flex.vertical,
    },
    {
      {
        Awful.titlebar.widget.minimizebutton(node),
        widget = Wibox.container.margin,
        margins = { top = DPI(5), right = DPI(13), left = DPI(13), bottom = DPI(3) },
      },
      {
        Awful.titlebar.widget.maximizedbutton(node),
        margins = { top = DPI(5), right = DPI(13), left = DPI(13), bottom = DPI(3) },
        widget = Wibox.container.margin,
      },
      {
        Awful.titlebar.widget.closebutton(node),
        margins = { top = DPI(5), right = DPI(13), left = DPI(13), bottom = DPI(13) },
        widget = Wibox.container.margin,
      },
      layout = Wibox.layout.fixed.vertical,
    },
    layout = Wibox.layout.align.vertical,
  }
end

return M
