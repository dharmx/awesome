local config = require("core.config").get()

local Awful = require("awful")
local Beautiful = require("beautiful")
require("awful.autofocus")

client.connect_signal("request::titlebars", function(node)
  local initialize = require("modules.titlebars." .. config.modules.titlebars.theme).initialize
  local Title = Awful.titlebar(node, { position = "top", size = Beautiful.titlebar_height })
  Title:setup(initialize(node))
end)
