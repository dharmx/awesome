local U = require("lib.std")

local Awful = require("awful")
local Ruled = require("ruled")

local rules = {
  {
    id = "global",
    rule = {},
    properties = {
      focus = Awful.client.focus.filter,
      raise = true,
      screen = Awful.screen.preferred,
      placement = Awful.placement.no_overlap + Awful.placement.no_offscreen,
    },
  },
  {
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      name = {
        "Event Tester",
      },
      role = {
        "AlarmWindow",
        "ConfigManager",
        "pop-up",
      },
    },
    properties = { floating = true },
  },
  {
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  },
}

Ruled.client.connect_signal("request::rules", function()
  U.table.foreachi(rules, function(_, rule)
    Ruled.client.append_rule(rule)
  end)
end)
