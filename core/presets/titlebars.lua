local M = {}
local shapes = require("core.shapes")

function M.pacman(theme, colors)
  theme.titlebar_close_button_normal = shapes.pacman(15, colors.bred:darken(2))
  theme.titlebar_close_button_focus = shapes.pacman(15, colors.red)
  theme.titlebar_close_button_normal_hover = shapes.circle(15, colors.bred:darken(2))
  theme.titlebar_close_button_focus_hover = shapes.circle(15, colors.red)
  theme.titlebar_close_button_focus_press = shapes.pacman(15, colors.yellow)
  theme.titlebar_close_button_normal_press = shapes.pacman(15, colors.yellow)

  theme.titlebar_maximized_button_normal_inactive = shapes.pacman(15, colors.magenta:darken(5))
  theme.titlebar_maximized_button_normal_inactive_press = shapes.pacman(15, colors.yellow)
  theme.titlebar_maximized_button_normal_inactive_hover = shapes.circle(15, colors.magenta:darken(5))

  theme.titlebar_maximized_button_focus_inactive = shapes.pacman(15, colors.magenta)
  theme.titlebar_maximized_button_focus_inactive_press = shapes.pacman(15, colors.yellow)
  theme.titlebar_maximized_button_focus_inactive_hover = shapes.circle(15, colors.bmagenta)

  theme.titlebar_minimize_button_normal = shapes.pacman(15, colors.cyan)
  theme.titlebar_minimize_button_focus = shapes.pacman(15, colors.bcyan)
  theme.titlebar_minimize_button_normal_hover = shapes.circle(15, colors.cyan)
  theme.titlebar_minimize_button_focus_hover = shapes.circle(15, colors.bcyan)
  theme.titlebar_minimize_button_focus_press = shapes.pacman(15, colors.yellow)
  theme.titlebar_minimize_button_normal_press = shapes.pacman(15, colors.yellow)
end

function M.tears(theme, colors)
  theme.titlebar_close_button_normal = shapes.tears(10, colors.bred)
  theme.titlebar_close_button_focus = shapes.tears(10, colors.red)

  theme.titlebar_maximized_button_normal_inactive = shapes.tears(10, colors.magenta:darken(5))
  theme.titlebar_maximized_button_focus_inactive = shapes.tears(10, colors.magenta)
  theme.titlebar_maximized_button_normal_active = shapes.tears(10, colors.bmagenta:darken(5))
  theme.titlebar_maximized_button_focus_active = shapes.tears(10, colors.bmagenta)

  theme.titlebar_minimize_button_normal = shapes.tears(10, colors.cyan)
  theme.titlebar_minimize_button_focus = shapes.tears(10, colors.bcyan)
end

return M
