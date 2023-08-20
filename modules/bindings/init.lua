local Awful = require("awful")
local Gears = require("gears")
local Filesystem = require("lfs")
local U = require("lib.std")

local factory = require("core.utils.factory")
local excludes = { ".", "..", "init.lua", "mouse.lua" }

for file in Filesystem.dir(Gears.filesystem.get_configuration_dir() .. "/modules/bindings") do
  if not Gears.table.hasitem(excludes, file) then
    local stem = factory.stem(file)
    local bindings = require("modules.bindings." .. stem)
    if U.table.is_list(bindings) then bindings = { [stem] = bindings } end
    factory.apply_bindings(bindings, false, Awful.keyboard.append_global_keybinding)
  end
end

local mouse = require("modules.bindings.mouse")
factory.apply_bindings({ mouse = mouse }, true, Awful.mouse.append_global_mousebinding)

client.connect_signal("request::default_mousebindings", function()
  local node_mouse = require("modules.bindings.node.mouse")
  factory.apply_bindings({ mouse = node_mouse }, true, Awful.mouse.append_client_mousebinding)
end)

client.connect_signal("request::default_keybindings", function()
  local node_keyboard = require("modules.bindings.node.keyboard")
  factory.apply_bindings({ keyboard = node_keyboard }, false, Awful.keyboard.append_client_keybinding)
end)
