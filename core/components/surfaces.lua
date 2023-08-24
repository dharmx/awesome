local M = {}

local Gears = require("gears")
local DPI = require("beautiful.xresources").apply_dpi

local function DEG(degree) return degree * (math.pi / 180) end

function M.circle(radius, pattern, background)
  local width = DPI(30)
  local height = DPI(30)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.circle(context, width, height, radius)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

function M.partial_squircle_left(width, height, rate, pattern, delta, background)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.partial_squircle(context, width, height, true, false, true, false, rate, delta)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

function M.partial_squircle_right(width, height, rate, pattern, delta, background)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.partial_squircle(context, width, height, false, true, false, true, rate, delta)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

function M.round_rectangle(radius, pattern, background)
  local width = DPI(30)
  local height = DPI(30)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.rounded_rect(context, width, height, radius)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

function M.flipped_parallelogram(width, height, base, pattern, background)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.transform(Gears.shape.parallelogram):rotate_at(
      width / 2,
      height / 2,
      DEG(90)
    )(context, width, height, base)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

function M.tears(radius, pattern, background)
  local width = DPI(30)
  local height = DPI(30)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.partially_rounded_rect(context, width, height, true, true, false, true, radius)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

function M.pacman(radius, pattern, mouth, background)
  mouth = if_nil(mouth, 0)
  local width = DPI(30)
  local height = DPI(30)
  return Gears.surface.load_from_shape(width, height, function(context)
    Gears.shape.pie(context, width, height, DEG(225) + mouth, DEG(130) - mouth, radius)
  end, pattern and pattern:to_hex(true), background and background:to_hex(true))
end

return M
