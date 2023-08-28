local config = require("core.config").get()
local surfaces = require("core.components.surfaces")
local colors = require("colors." .. config.colors).background[config.background]
local DPI = require("beautiful.xresources").apply_dpi
local Gears = require("gears")

local theme = {}
local theme_path = Gears.filesystem.get_themes_dir() .. "tears"

theme.icon_theme = config.icon_theme
theme.font = "Dosis 11"
theme.titlebar_height = DPI(50)
theme.wallpaper = theme_path .. "/background.png"
theme.logo = theme_path .. "/logo.png"
theme.logo_border_color = colors.bblue:to_hex(true)

theme.bg_focus = colors.black:lighten(2):to_hex(true)
theme.bg_normal = colors.bblack:darken(2):to_hex(true)
theme.bg_urgent = colors.red:to_hex(true)
theme.bg_minimize = colors.bblack:lighten(2):to_hex(true)
theme.bg_systray = colors.bblack:to_hex(true)

theme.fg_normal = colors.white:to_hex(true)
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = colors.bwhite:to_hex(true)

theme.useless_gap = DPI(10)
theme.border_width = DPI(0)
theme.border_color_normal = colors.green:to_hex(true)
theme.border_color_active = colors.magenta:to_hex(true)
theme.border_color_marked = colors.red:brighten(5):to_hex(true)

theme.wibar_bg = colors.black:to_hex(true)
theme.wibar_left_separator_fg = colors.black:brighten(20):to_hex(true)
theme.wibar_left_time_hour_fg = colors.red:to_hex(true)
theme.wibar_left_time_minute_fg = colors.black:brighten(20):to_hex(true)

theme.wibar_right_bg = colors.black:lighten(2):to_hex(true)
theme.wibar_profile_separator_fg = colors.black:brighten(10):to_hex(true)
theme.wibar_right_separator_fg = colors.black:brighten(20):to_hex(true)
theme.wibar_right_dropdown_icon_stroke = colors.bblack:lighten(40):to_hex(true)
theme.wibar_right_dropdown_icon_bg = colors.green:to_hex(true)
theme.wibar_right_dropdown_icon_fg = colors.bblack:lighten(10):to_hex(true)
theme.wibar_right_dropdown_icon_outline = colors.bblack:lighten(20):to_hex(true)
theme.wibar_right_dropdown_label_fg = colors.white:to_hex(true)
theme.wibar_right_dropdown_collapse_stroke = colors.bblack:lighten(40):to_hex(true)
theme.wibar_right_dropdown_bg = colors.black:lighten(3):brighten(3):to_hex(true)
theme.wibar_right_dropdown_on_enter_bg = colors.black:lighten(2):brighten(6):to_hex(true)
theme.wibar_right_dropdown_on_leave_bg = theme.wibar_right_dropdown_bg
theme.wibar_right_detached_button_icon_bg = colors.black:brighten(10):to_hex(true)
theme.wibar_right_detached_button_icon_stroke = colors.white:darken(10):to_hex(true)
theme.wibar_right_detached_button_signal_on_enter = colors.black:lighten(5):brighten(10):to_hex(true)
theme.wibar_right_detached_button_signal_on_leave = colors.bblack:lighten(10):to_hex(true)

theme.taglist_regulate_bg = colors.black:lighten(2):to_hex(true)
theme.taglist_regulate_increase_bg = colors.bred:to_hex(true)
theme.taglist_regulate_decrease_bg = colors.bblack:lighten(7):to_hex(true)
theme.taglist_shape = Gears.shape.circle
-- theme.taglist_shape_border_color = theme.bg_normal
-- theme.taglist_shape_border_width = DPI(10)

theme.taglist_bg = colors.black:brighten(2):to_hex(true)
theme.taglist_bg_focus = colors.bblue:to_hex(true)
theme.taglist_bg_urgent = colors.bred:to_hex(true)
theme.taglist_bg_occupied = colors.bgreen:to_hex(true)
theme.taglist_bg_empty = colors.bblack:brighten(5):lighten(5):to_hex(true)
theme.taglist_spacing = DPI(10)

theme.radial_cpu_bg = colors.bblack:lighten(7):to_hex(true)
theme.radial_cpu_arc_bg = colors.bblack:lighten(12):to_hex(true)
theme.radial_cpu_arc_fg = colors.blue:to_hex(true)
theme.radial_cpu_arc_body_bg = colors.bblack:lighten(14):to_hex(true)
theme.radial_cpu_icon_stroke = colors.bblue:to_hex()

theme.radial_ram_bg = colors.bblack:lighten(7):to_hex(true)
theme.radial_ram_arc_bg = colors.bblack:lighten(12):to_hex(true)
theme.radial_ram_arc_fg = colors.magenta:to_hex(true)
theme.radial_ram_arc_body_bg = colors.bblack:lighten(14):to_hex(true)
theme.radial_ram_icon_stroke = colors.bmagenta:to_hex(true)

theme.menu_height = DPI(15)
theme.menu_width = DPI(100)

theme.titlebar_close_button_normal = surfaces.tears(10, colors.bred:to_hex(true))
theme.titlebar_close_button_focus = surfaces.tears(10, colors.red:to_hex(true))

theme.titlebar_maximized_button_normal = surfaces.tears(10, colors.magenta:to_hex(true))
theme.titlebar_maximized_button_normal_active = surfaces.tears(10, colors.magenta:darken(10):to_hex(true))
theme.titlebar_maximized_button_normal_active_hover = surfaces.tears(10, colors.magenta:to_hex(true))
theme.titlebar_maximized_button_normal_active_press = surfaces.tears(10, colors.bblue:to_hex(true))
theme.titlebar_maximized_button_normal_inactive = surfaces.tears(10, colors.magenta:darken(10):to_hex(true))
theme.titlebar_maximized_button_normal_inactive_hover = surfaces.tears(10, colors.magenta:to_hex(true))
theme.titlebar_maximized_button_normal_inactive_press = surfaces.tears(10, colors.bblue:to_hex(true))

theme.titlebar_maximized_button_focus = surfaces.tears(10, colors.magenta:to_hex(true))
theme.titlebar_maximized_button_focus_active = surfaces.tears(10, colors.magenta:darken(10):to_hex(true))
theme.titlebar_maximized_button_focus_active_hover = surfaces.tears(10, colors.magenta:to_hex(true))
theme.titlebar_maximized_button_focus_active_press = surfaces.tears(10, colors.bblue:to_hex(true))
theme.titlebar_maximized_button_focus_inactive = surfaces.tears(10, colors.magenta:to_hex(true))
theme.titlebar_maximized_button_focus_inactive_hover = surfaces.tears(10, colors.magenta:darken(10):to_hex(true))
theme.titlebar_maximized_button_focus_inactive_press = surfaces.tears(10, colors.magenta:to_hex(true))

theme.titlebar_minimize_button_normal_hover = surfaces.tears(10, colors.cyan:darken(10):to_hex(true))
theme.titlebar_minimize_button_normal = surfaces.tears(10, colors.cyan:to_hex(true))
theme.titlebar_minimize_button_focus = surfaces.tears(10, colors.bcyan:to_hex(true))

-- theme.titlebar_methman_minimize = colors.cyan:to_hex(true)
-- theme.titlebar_methman_maximize = colors.magenta:to_hex(true)
-- theme.titlebar_methman_close = colors.red:to_hex(true)

-- theme.titlebar_pacman_minimize = colors.cyan:to_hex(true)
-- theme.titlebar_pacman_maximize = colors.magenta:to_hex(true)
-- theme.titlebar_pacman_close = colors.red:to_hex(true)

-- theme.flash_focus_start_opacity = 0.6
-- theme.flash_focus_step = 0.01

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
