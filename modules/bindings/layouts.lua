local Awful = require("awful")

local enum = require("core.enum")
local SUPER = enum.modifiers.SUPER
local SHIFT = enum.modifiers.SHIFT
local ALT = enum.modifiers.ALT
local CTRL = enum.modifiers.CTRL

return {
  {
    modifiers = SUPER + SHIFT,
    key = "l",
    on_press = function() Awful.tag.incmwfact(0.01) end,
    description = "Increase master width factor.",
  },
  {
    modifiers = SUPER + SHIFT,
    key = "h",
    on_press = function() Awful.tag.incmwfact(-0.01) end,
    description = "Decrease master width factor.",
  },
  {
    modifiers = SUPER + SHIFT,
    key = "j",
    on_press = function() Awful.client.incwfact(0.05) end,
    description = "Increase client height factor.",
  },
  {
    modifiers = SUPER + SHIFT,
    key = "k",
    on_press = function() Awful.client.incwfact(-0.05) end,
    description = "Decrease client height factor.",
  },
  {
    modifiers = SUPER,
    key = ";",
    on_press = function() Awful.layout.inc(-1) end,
    description = "Select previous.",
  },
  {
    modifiers = SUPER,
    key = "'",
    on_press = function() Awful.layout.inc(1) end,
    description = "Select previous.",
  },
}
