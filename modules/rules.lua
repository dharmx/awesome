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
      instance = { "pinentry" },
      class = {
        "glava",
        "mpv",
        "screenkey",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "spotify",
        "Zathura",
        "feh",
        "Pavucontrol",
        "Gnome-disks",
        "blueman-manager",
        "blueman-adapters",
        "dconf-editor",
        "Git-gui",
        "Nemo",
        "Shotwell",
        "firefox",
        "Seahorse",
        "Qalculate-gtk",
        "aft-linux-qt",
        "qBittorrent",
        "Ghostscript",
        "Gmtp",
        "Zim",
        "obs",
        "Shotcut",
        "Xscreensaver-settings",
        "Font-viewer",
        "Font-manager",
        "discord",
        "Kvantum Manager",
        "SimpleScreenRecorder",
        "VirtualBox Manager",
        "Anki",
        "Nm-connection-editor",
        "doxywizard",
        "Blueman-manager",
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
    rule_any = {
      type = {
        "normal",
        "dialog"
      },
      class = {
        "Xephyr",
      },
    },
    properties = { titlebars_enabled = true },
  },
}

Ruled.client.connect_signal("request::rules", function()
  U.table.foreachi(rules, function(_, rule)
    Ruled.client.append_rule(rule)
  end)
end)
