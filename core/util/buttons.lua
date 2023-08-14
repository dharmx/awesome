local M = {}

local shapes = require("core.util.shapes")
local if_nil = require("lib.functional").if_nil

local Rubato = require("rubato")
local Awful = require("awful")
local U = require("lib.std")

function M.pacman(radius, pattern, buttons, options)
  assert(radius and pattern)
  buttons = if_nil(buttons, {})
  options = if_nil(options, {})
  options = U.table.deep_extend("keep", options, { resize = true, visible = true })
  options.image = shapes.pacman(radius, pattern)
  options.buttons = U.table.is_list(buttons) and U.table.map(function(button)
    return Awful.button(button)
  end, buttons) or { Awful.button(buttons) }

  local button = Awful.widget.button(options)
  local timed = Rubato.timed({
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
