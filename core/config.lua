local M = {}

local Gears = require("gears")
local Beautiful = require("beautiful")

local functional = require("core.functional")
local std = require("core.std")
local factory = require("core.util.factory")
local environ = require("core.enum").environ

environ.AWESOME_THEMES_PATH = environ.XDG_CONFIG_HOME .. "/awesome/themes"
M._defaults = {
  theme = "tears",
  colors = "shore",
  background = "dark",
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
      terminal = functional.if_nil(environ.TERMINAL, "xterm"),
      editor = functional.if_nil(environ.EDITOR, "nano"),
      modkey = "Mod4",
    },
    titlebars = {
      theme = "tears",
    },
    wibars = {
      style = "tears",
      tag = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
    },
  },
}

M._defaults.modules.variables.editor_cmd = M._defaults.modules.variables.terminal .. " -e " .. M._defaults.modules.variables.editor
M._current = Gears.table.clone(M._defaults, true)

function M.merge(options)
  M._current = std.table.deep_extend("keep", functional.if_nil(options, {}), M._current)
  return M._current
end

function M.extend(options) return std.table.deep_extend("keep", functional.if_nil(options, {}), M._current) end

function M.get() return M._current end

return M
