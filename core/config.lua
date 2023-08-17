local M = {}

local Beautiful = require("beautiful")
local Gears = require("gears")
local U = require("lib.std")

local if_nil = require("lib.functional").if_nil
local factory = require("core.util.factory")
local environ = require("core.enum").environ

environ.AWESOME_THEMES_PATH = environ.XDG_CONFIG_HOME .. "/awesome/themes"
M._defaults = {
  theme = "tears",
  colors = "radium",
  background = "dark",
  flash = false,
  wallpapers = {
    position = "maximized",
    offset = { x = -130, y = 0 },
    wallpaper = environ.XDG_PICTURES_DIR .. "/concepts/radium.jpg",
    image_formats = { "jpg", "jpeg", "png", "bmp", "webp", "jiff" },
    recursive = true,
    background = Beautiful.bg_normal,
    ignore_aspect = false,
  },
  modules = {
    variables = {
      icon_theme = factory.get_current_icon_theme_name(),
      terminal = if_nil(environ.TERMINAL, "xterm"),
      editor = if_nil(environ.EDITOR, "nano"),
      modkey = "Mod4",
    },
    titlebars_theme = "tears",
    wibars = {
      style = "tears",
    },
  },
}

M._defaults.modules.variables.editor_cmd = M._defaults.modules.variables.terminal .. " -e " .. M._defaults.modules.variables.editor
M._current = Gears.table.clone(M._defaults, true)

function M.merge(options)
  M._current = U.table.deep_extend("keep", if_nil(options, {}), M._current)
  return M._current
end

function M.extend(options) return U.table.deep_extend("keep", if_nil(options, {}), M._current) end

function M.get() return M._current end

return M
