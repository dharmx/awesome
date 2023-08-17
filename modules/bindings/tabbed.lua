local Bling = require("bling")
local enum = require("core.enum")
local SUPER = enum.modifiers.SUPER
local ALT = enum.modifiers.ALT

return {
  {
    modifiers = SUPER + ALT,
    key = "p",
    description = "Picks a client with your cursor to add to the tabbing group.",
    on_press = function()
      Bling.module.tabbed.pick()
    end,
  },
  {
    modifiers = SUPER + ALT,
    key = "o",
    description = "Removes the focused client from the tabbing group.",
    on_press = function()
      Bling.module.tabbed.pop()
    end,
  },
  {
    modifiers = SUPER + ALT,
    key = "i",
    description = "Iterates through the currently focused tabbing group.",
    on_press = function()
      Bling.module.tabbed.iter()
    end,
  },
}
