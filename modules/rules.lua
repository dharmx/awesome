local Awful = require("awful")
local Ruled = require("ruled")

Ruled.client.connect_signal("request::rules", function()
  Ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = Awful.client.focus.filter,
      raise = true,
      screen = Awful.screen.preferred,
      placement = Awful.placement.no_overlap + Awful.placement.no_offscreen,
    },
  })

  Ruled.client.append_rule({
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
  })

  Ruled.client.append_rule({
    id = "titlebars",
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  })
end)
