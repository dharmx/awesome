local Awful = require("awful")
require("awful.autofocus")

local config = require("core.config").get()
local theme = require("modules.bars." .. config.modules.bars_theme)

screen.connect_signal("request::desktop_decoration", function(local_screen)
  Awful.tag({ "1", "2", "3", "4", "5" }, local_screen, Awful.layout.layouts[1])
  local_screen.mywibox = Awful.wibar(theme.initialize(local_screen))
end)
