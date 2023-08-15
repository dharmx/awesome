local M = {}

local shapes = require("core.util.shapes")

local Rubato = require("rubato")
local Awful = require("awful")
local GearsTime = require("gears.timer")

local F = require("lib.functional")
local T = require("lib.tiny")

M.pacman = setmetatable({}, {
  __call = function(_, radius, pattern)
    assert(radius, "pacman needs a radius")
    pattern = F.if_nil(pattern, T("yellow"))
    local button = Awful.widget.button({
      resize = true,
      visible = true,
      image = shapes.pacman(radius, pattern),
    })

    button.timed = Rubato.timed({
      duration = 0.3,
      subscribed = function(position)
        button:set_image(shapes.pacman(radius, pattern, -position))
      end,
    })

    button:connect_signal("mouse::enter", function() button.timed.target = 0.5 end)
    button:connect_signal("mouse::leave", function() button.timed.target = 0 end)
    return button
  end,
})

function M.pacman.minimize(node, radius, pattern)
  local button = M.pacman(radius, pattern)
  button:connect_signal("button::press", function()
    ---@see https://github.com/awesomeWM/awesome/issues/3716
    GearsTime.delayed_call(function()
      node.minimized = true
    end, 0.05)
  end)
  return button
end

function M.pacman.maximize(node, radius, pattern)
  local button = M.pacman(radius, pattern)
  button:connect_signal("button::press", function()
    node.maximized = not node.maximized
  end)
  return button
end

function M.pacman.close(node, radius, pattern)
  local button = M.pacman(radius, pattern)
  button:connect_signal("button::press", function()
    node:kill()
  end)
  return button
end

return M
