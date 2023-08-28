local M = {}

local Wibox = require("wibox")

function M.new(options)
  local imagebox = Wibox.widget.imagebox()
  awesome.connect_signal("signal::battery", function(percentage)
    if percentage >= 95 then
      imagebox.image = options.safe_image
      imagebox.stylesheet = options.safe_style
    elseif percentage >= 80 then
      imagebox.image = options.eighty_image
      imagebox.stylesheet = options.eighty_style
    elseif percentage >= 60 then
      imagebox.image = options.sixty_image
      imagebox.stylesheet = options.sixty_style
    elseif percentage >= 40 then
      imagebox.image = options.fourty_image
      imagebox.stylesheet = options.fourty_style
    elseif percentage > 30 then
      imagebox.image = options.thirty_image
      imagebox.stylesheet = options.thirty_style
    elseif percentage >= 20 then
      imagebox.image = options.twenty_image
      imagebox.stylesheet = options.twenty_style
    else
      imagebox.image = options.critical_image
      imagebox.stylesheet = options.critical_style
    end
  end)
  return imagebox
end

setmetatable(M, {
  __call = function(self, options)
    return self.new(options)
  end,
})
return M
