local config = require("core.config").get()
local shapes = require("core.components.shapes")
local colors = require("colors." .. config.colors).background[config.background]
local DPI = require("beautiful.xresources").apply_dpi

local Assets = require("beautiful.theme_assets")
local Gears = require("gears")

local theme = {}
local theme_path = Gears.filesystem.get_themes_dir() .. "tears"

theme.icon_theme = config.icon_theme
theme.font = "Dosis 11"
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

theme.titlebar_close_button_normal = shapes.tears(10, colors.bred)
theme.titlebar_close_button_focus = shapes.tears(10, colors.red)

theme.titlebar_maximized_button_normal = shapes.tears(10, colors.magenta)
theme.titlebar_maximized_button_normal_active = shapes.tears(10, colors.magenta:darken(10))
theme.titlebar_maximized_button_normal_active_hover = shapes.tears(10, colors.magenta)
theme.titlebar_maximized_button_normal_active_press = shapes.tears(10, colors.bblue)
theme.titlebar_maximized_button_normal_inactive = shapes.tears(10, colors.magenta:darken(10))
theme.titlebar_maximized_button_normal_inactive_hover = shapes.tears(10, colors.magenta)
theme.titlebar_maximized_button_normal_inactive_press = shapes.tears(10, colors.bblue)

theme.titlebar_maximized_button_focus = shapes.tears(10, colors.magenta)
theme.titlebar_maximized_button_focus_active = shapes.tears(10, colors.magenta:darken(10))
theme.titlebar_maximized_button_focus_active_hover = shapes.tears(10, colors.magenta)
theme.titlebar_maximized_button_focus_active_press = shapes.tears(10, colors.bblue)
theme.titlebar_maximized_button_focus_inactive = shapes.tears(10, colors.magenta)
theme.titlebar_maximized_button_focus_inactive_hover = shapes.tears(10, colors.magenta:darken(10))
theme.titlebar_maximized_button_focus_inactive_press = shapes.tears(10, colors.magenta.bblue)

theme.titlebar_minimize_button_normal_hover = shapes.tears(10, colors.cyan:darken(10))
theme.titlebar_minimize_button_normal = shapes.tears(10, colors.cyan)
theme.titlebar_minimize_button_focus = shapes.tears(10, colors.bcyan)

theme.flash_focus_start_opacity = 0.6
theme.flash_focus_step = 0.01

theme.tabbed_spawn_in_tab = false
theme.tabbar_ontop = false
theme.tabbar_radius = 0
theme.tabbar_style = "modern"
theme.tabbar_font = "Dosis 11"
theme.tabbar_size = 45
theme.tabbar_position = "bottom"
theme.tabbar_bg_normal = colors.black:lighten(2):to_hex(true)
theme.tabbar_fg_normal = colors.white:to_hex(true)
theme.tabbar_bg_focus = colors.black:to_hex(true)
theme.tabbar_fg_focus = colors.white:to_hex(true)
theme.tabbar_bg_focus_inactive = colors.bblack:lighten(2):brighten(2):to_hex(true)
theme.tabbar_fg_focus_inactive = colors.white:darken(2):to_hex(true)
theme.tabbar_bg_normal_inactive = colors.black:lighten(2):brighten(2):to_hex(true)
theme.tabbar_fg_normal_inactive = colors.white:darken(2):to_hex(true)
theme.tabbar_disable = false

theme.tabbar_color_close = colors.red:to_hex(true)
theme.tabbar_color_min = colors.cyan:to_hex(true)
theme.tabbar_color_float = colors.magenta:to_hex(true)

theme.bg_systray = "#0F1014"
theme.systray_max_rows = 1
theme.systray_icon_spacing = DPI(2)

return theme
