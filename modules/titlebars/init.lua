local config = require("core.config").get()
local colors = require("colors." .. config.colors).background[config.background]
local theme = require("modules.titlebars." .. config.modules.titlebars_theme)

local Awful = require("awful")
local Beautiful = require("beautiful")
require("awful.autofocus")

local function title(node, position)
  return Awful.titlebar(node, { position = position, size = Beautiful.titlebar_height })
end

client.connect_signal("request::titlebars", function(node)
  -- Smart titlebars.
  -- title(node, "left"):setup(theme.left(node, colors))
  -- title(node, "top"):setup(theme.top(node, colors))
  -- Awful.titlebar.hide(node, "top")

  -- Normal titlebars.
  -- prefers sloppy-toppy
  title(node, "top"):setup(theme.top(node, colors))
end)

-- Smart titlebars.
-- client.connect_signal("request::geometry", function(node, _, geometry)
--   if not geometry then return end
--   if geometry.width < 900 then
--     Awful.titlebar.hide(node, "left")
--     Awful.titlebar.show(node, "top")
--   else
--     Awful.titlebar.hide(node, "top")
--     Awful.titlebar.show(node, "left")
--   end
-- end)

-- Hides titlebars when tabbed layout is in effect.
awesome.connect_signal("bling::tabbed::client_added", function(tabbed)
  for _, node in ipairs(tabbed.clients) do
    Awful.titlebar.hide(node, "top")
  end
end)
awesome.connect_signal("bling::tabbed::client_removed", function(_, removed_node)
  Awful.titlebar.show(removed_node, "top")
end)
