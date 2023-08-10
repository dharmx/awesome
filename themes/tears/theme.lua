local config = require("core.config").get()
local colors = require("colors." .. config.colors).background[config.background]
local DPI = require("beautiful.xresources").apply_dpi

local Assets = require("beautiful.theme_assets")
local Gears = require("gears")

local theme = {}
local theme_path = Gears.filesystem.get_themes_dir() .. "tears"

theme.icon_theme = config.icon_theme
theme.font = "Nunito 10"
theme.titlebar_height = DPI(50)
theme.wallpaper = theme_path .. "/background.png"

theme.bg_focus = colors.black:lighten(2):to_hex(true)
theme.bg_normal = colors.bblack:darken(2):to_hex(true)
theme.bg_urgent = colors.red:to_hex(true)
theme.bg_minimize = colors.bblack:lighten(2):to_hex(true)
theme.bg_systray = colors.bblack:to_hex(true)

theme.fg_normal = colors.white:to_hex(true)
theme.fg_focus = colors.white:to_hex(true)
theme.fg_urgent = colors.white:to_hex(true)
theme.fg_minimize = colors.bwhite:to_hex(true)

theme.useless_gap = DPI(10)
theme.border_width = DPI(0)
theme.border_color_normal = colors.green:to_hex(true)
theme.border_color_active = colors.magenta:to_hex(true)
theme.border_color_marked = colors.red:brighten(5):to_hex(true)

theme.taglist_squares_sel = Assets.taglist_squares_sel(DPI(4), theme.fg_normal)
theme.taglist_squares_unsel = Assets.taglist_squares_unsel(DPI(4), theme.fg_normal)

theme.menu_height = DPI(15)
theme.menu_width = DPI(100)
require("core.presets.titlebars")[config.modules.titlebars.style](theme, colors)

theme.flash_focus_start_opacity = 0.6
theme.flash_focus_step = 0.01

return theme
