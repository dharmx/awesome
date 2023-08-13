local config = require("core.config").get()

local Awful = require("awful")
local Beautiful = require("beautiful")
require("awful.autofocus")

client.connect_signal("request::titlebars", function(node)
  local colors = require("colors." .. config.colors).background[config.background]
  local Title = Awful.titlebar(node, { position = "top", size = Beautiful.titlebar_height })
  Title:setup(require("modules.titlebars." .. config.modules.titlebars.theme).initialize(node, colors))
end)
