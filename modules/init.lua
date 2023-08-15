local M = {}

local Gears = require("gears")
local Beautiful = require("beautiful")
local Filesystem = require("lfs")
local Bling = require("bling")

local config = require("core.config")
local factory = require("core.util.factory")
local if_nil = require("lib.functional").if_nil

function M.setup(options)
  require("awful.hotkeys_popup.keys")
  require("awful.autofocus")

  -- load changes to defaults
  options = config.merge(options)
  require("modules.variables") -- top priority module as other modules depend on it
  local excludes = { ".", "..", "init.lua", "variables.lua" }
  for file in Filesystem.dir(Gears.filesystem.get_configuration_dir() .. "/modules") do
    -- "balls.lua" -> "balls"
    if not Gears.table.hasitem(excludes, file) then require("modules." .. factory.stem(file)) end
  end

  if options.flash then Bling.module.flash_focus.enable() end
  local wallpapers = Gears.table.clone(config.get().wallpapers, true)
  wallpapers.wallpaper = if_nil(wallpapers.wallpaper, Beautiful.wallpaper)
  Bling.module.wallpaper.setup(wallpapers)
end

return M
