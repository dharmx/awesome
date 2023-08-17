local Awful = require("awful")
require("awful.autofocus")

screen.connect_signal("request::desktop_decoration", function(local_screen)
  Awful.tag({ "1", "2", "3" }, local_screen, Awful.layout.layouts[1])
end)
