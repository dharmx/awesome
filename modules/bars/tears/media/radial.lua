local M = {}
local Wibox = require("wibox")
local F = require("lib.functional")
local DPI = require("beautiful.xresources").apply_dpi

function M.new(options)
  options = F.if_nil(options, {})
  options.value = F.if_nil(options.value, 0)
  options.max_value = F.if_nil(options.max_value, 1)
  options.min_value = F.if_nil(options.min_value, 0)
  options.icon = F.if_nil(options.icon, {})
  options.radial = F.if_nil(options.radial, {})
  options.radial.thickness = F.if_nil(options.thickness , DPI(5))
  options.radial.rounded_edge = F.if_nil(options.radial.rounded_edge, true)

  local arcchart = Wibox.container.arcchart({
    bg = assert(options.radial.body_background, "please supply a radial.body_background"),
    widget = Wibox.container.background,
  })

  arcchart.max_value = options.max_value
  arcchart.min_value = options.max_value
  arcchart.bg = assert(options.background, "please supply a background")
  arcchart.forced_width = options.radial.forced_width
  arcchart.forced_height = options.radial.forced_height
  arcchart.value = options.value
  arcchart.colors = { assert(options.radial.foreground, "please supply radial.foreground") }
  arcchart.rounded_edge = true
  arcchart.border_color = assert(options.radial.background, "please supply a radial.background")
  arcchart.thickness = options.radial.thickness
  arcchart.paddings = options.paddings
  return arcchart
end

setmetatable(M, {
  __call = function(self, options)
    return self.new(options)
  end,
})
return M
