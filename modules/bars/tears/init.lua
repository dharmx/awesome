local M = {}
setmetatable(M, {
  __index = function(_, key)
    return require("modules.bars.tears." .. key)
  end,
})

local Wibox = require("wibox")
local Gears = require("gears")
local Resource = require("core.utils.factory").resource_factory()

local U = require("lib.std")
local DPI = require("beautiful.xresources").apply_dpi
local colors = require("colors").get()

function M.initialize(local_screen)
  return {
    position = "top",
    screen = local_screen,
    height = DPI(70),
    bg = colors.black:to_hex(true),
    widget = {
      nil,
      nil,
      {
        {
          {
            {
              {
                {
                  {
                    M.media.radial(colors, {
                      icon = Resource.cpu,
                      stylesheet = string.format("*{fill:#%s;}", colors.bblue:to_hex()),
                      radial_foreground = colors.blue:to_hex(true),
                      max_value = 100,
                      min_value = 0,
                      interval = 5,
                      command = "cat /proc/stat",
                      update = function(self, stats, _, _, exitcode)
                        if exitcode == 0 then
                          local cpu = U.string.split(U.string.split(stats, "\n", { plain = true })[1], " ", { plain = true })
                          cpu = U.table.slice(cpu, 2)
                          cpu = U.table.map(tonumber, cpu)
                          local new_value = 100 - ((cpu[4] * 100) / (cpu[1] + cpu[2] + cpu[3] + cpu[4] + cpu[5] + cpu[6] + cpu[7] + cpu[8] + cpu[9]))
                          self:set_value(new_value)
                        end
                      end,
                    }),
                    right = DPI(3),
                    widget = Wibox.container.margin,
                  },
                  {
                    M.media.radial(colors, {
                      radial_foreground = colors.magenta:to_hex(true),
                      max_value = 16,
                      min_value = 0,
                      interval = 5,
                      command = "free --giga",
                      update = function(self, free, _, _, exitcode)
                        if exitcode == 0 then
                          local parsed = U.string.split(free, "\n", { plain = true })[2]
                          local new_value = tonumber(U.string.split(parsed, " +", { plain = false })[3])
                          self:set_value(new_value)
                        end
                      end
                    }),
                    widget = Wibox.container.margin,
                  },
                  layout = Wibox.layout.fixed.horizontal,
                },
                top = DPI(5),
                bottom = DPI(5),
                left = DPI(4),
                right = DPI(5),
                layout = Wibox.container.margin,
              },
              {
                M.media.slash(colors),
                left = DPI(8),
                right = DPI(8),
                layout = Wibox.container.margin,
              },
              {
                M.media.dropdown(colors),
                left = DPI(5),
                layout = Wibox.container.margin,
              },
              {
                M.media.slash(colors),
                left = DPI(8),
                right = DPI(8),
                layout = Wibox.container.margin,
              },
              {
                M.media.detached_button(colors),
                left = DPI(5),
                right = DPI(8),
                layout = Wibox.container.margin,
              },
              homogeneous = false,
              layout = Wibox.layout.grid.horizontal,
            },
            top = DPI(5),
            bottom = DPI(5),
            right = DPI(5),
            left = DPI(5),
            layout = Wibox.container.margin,
          },
          bg = colors.black:lighten(2):to_hex(true),
          shape = function(context, width, height)
            Gears.shape.rounded_rect(context, width, height, DPI(25))
          end,
          widget = Wibox.container.background,
        },
        top = DPI(10),
        bottom = DPI(10),
        right = DPI(10),
        layout = Wibox.container.margin,
      },
      layout = Wibox.layout.align.horizontal,
    },
  }
end

return M
