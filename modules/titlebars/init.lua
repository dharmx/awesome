local config = require("core.config").get()
local colors = require("colors." .. config.colors).background[config.background]
local theme = require("modules.titlebars." .. config.modules.titlebars.theme)

local Awful = require("awful")
local Beautiful = require("beautiful")

require("awful.autofocus")
if not config.modules.titlebars.enabled then return end
local function title(node, position)
  return Awful.titlebar(node, { position = position, size = Beautiful.titlebar_height })
end

client.connect_signal("request::titlebars", function(node)
  title(node, "left"):setup(theme.left(node, colors))
  if config.modules.titlebars.resize then
    title(node, "top"):setup(theme.top(node, colors))
    Awful.titlebar.hide(node, "top")
  end
end)

if config.modules.titlebars.resize then
  client.connect_signal("request::geometry", function(node, _, geometry)
    if geometry.width < 900 then
      Awful.titlebar.hide(node, "left")
      Awful.titlebar.show(node, "top")
    else
      Awful.titlebar.hide(node, "top")
      Awful.titlebar.show(node, "left")
    end
  end)
end
