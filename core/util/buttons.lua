local M = {}

local shapes = require("core.util.shapes")
local std = require("core.std")
local functional = require("core.functional")

local Rubato = require("rubato")
local Awful = require("awful")

function M.pacman(radius, pattern, buttons, options)
  assert(radius and pattern)
  buttons = functional.if_nil(buttons, {})
  options = functional.if_nil(options, {})
  options = std.table.deep_extend("keep", options, { resize = true, visible = true })
  options.image = shapes.pacman(radius, pattern)
  options.buttons = std.table.is_list(buttons) and std.table.map(function(button)
    return Awful.button(button)
  end, buttons) or { Awful.button(buttons) }

  local button = Awful.widget.button(options)
  local timed = Rubato.timed({
    intro = 0,
    duration = 0.3,
    subscribed = function(position)
      button:set_image(shapes.pacman(radius, pattern, -position))
    end,
  })

  button:connect_signal("mouse::enter", function() timed.target = 0.5 end)
  button:connect_signal("mouse::leave", function() timed.target = 0 end)
  return button
end

return M
