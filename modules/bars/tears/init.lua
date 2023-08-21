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
local widgets = require("core.components.widgets")

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
                    widgets.poll_file("/proc/stat", 2, function(self, stat)
                      local cpu = U.string.split(U.string.split(stat, "\n", { plain = true })[1], " ", { plain = true })
                      cpu = U.table.slice(cpu, 2)
                      cpu = U.table.map(tonumber, cpu)
                      local new_value = 100 - ((cpu[4] * 100) / (cpu[1] + cpu[2] + cpu[3] + cpu[4] + cpu[5] + cpu[6] + cpu[7] + cpu[8] + cpu[9]))
                      self:set_value(new_value)
                    end, M.media.radial({
                      background = colors.bblack:lighten(7):to_hex(true),
                      radial = {
                        background = colors.bblack:lighten(12):to_hex(true),
                        foreground = colors.blue:to_hex(true),
                        body_background = colors.bblack:lighten(14):to_hex(true),
                        forced_width = DPI(33),
                      },
                      icon = {
                        resource = Resource.cpu,
                        stylesheet = string.format("*{fill:#%s;}", colors.bblue:to_hex()),
                      },
                      max_value = 100,
                      min_value = 0,
                    })),
                    right = DPI(3),
                    widget = Wibox.container.margin,
                  },
                  {
                    widgets.poll_file("/proc/meminfo", 2, function(self, meminfo)
                      local ram = {}
                      U.table.foreachi(U.string.split(U.string.trim(meminfo), "\n"), function(_, line)
                        local splits = U.string.split(line, ": +", { plain = false })
                        ram[splits[1]] = tonumber(U.string.split(splits[2], " ", { plain = true })[1])
                      end)
                      local new_value = (ram.MemTotal - ram.MemFree - ram.Buffers - ram.Cached) / 1024 ^ 2
                      self:set_value(new_value)
                    end, M.media.radial({
                      background = colors.bblack:lighten(7):to_hex(true),
                      radial = {
                        background = colors.bblack:lighten(12):to_hex(true),
                        foreground = colors.magenta:to_hex(true),
                        body_background = colors.bblack:lighten(14):to_hex(true),
                        forced_width = DPI(33),
                      },
                      icon = {
                        resource = Resource.disc,
                        stylesheet = string.format("*{fill:#%s;}", colors.bblue:to_hex()),
                      },
                      max_value = 16,
                      min_value = 0,
                    })),
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
                M.media.slash({
                  font = "Dosis 15",
                  foreground = colors.white:darken(30):to_hex(true),
                }),
                left = DPI(8),
                right = DPI(8),
                layout = Wibox.container.margin,
              },
              {
                M.media.dropdown({
                  icon = {
                    resource = Resource.flag_banner,
                    stylesheet = string.format("*{fill:#%s;}", colors.bblack:lighten(40):to_hex()),
                    background = colors.green:to_hex(true),
                    forced_width = DPI(20),
                    foreground = colors.bblack:lighten(10):to_hex(true),
                    outline = colors.bblack:lighten(20):to_hex(true),
                  },
                  label = {
                    font = "Dosis 12",
                    text = "Quick Navigation",
                    foreground = colors.white:to_hex(true),
                  },
                  collapse = {
                    resource = Resource.caret_down,
                    stylesheet = string.format("*{fill:#%s;}", colors.bblack:lighten(40):to_hex()),
                    forced_width = DPI(20),
                  },
                  signal = {
                    dropdown = {
                      on_enter = function(self, _)
                        self:set_bg(colors.black:lighten(2):brighten(6):to_hex(true))
                      end,
                      on_leave = function(self, _)
                        self:set_bg(colors.black:lighten(2):to_hex(true))
                      end,
                    }
                  },
                }),
                left = DPI(5),
                layout = Wibox.container.margin,
              },
              {
                M.media.slash({
                  font = "Dosis 15",
                  foreground = colors.white:darken(30):to_hex(true),
                }),
                left = DPI(8),
                right = DPI(8),
                layout = Wibox.container.margin,
              },
              {
                M.media.detached_button({
                  label = {
                    text = "Essentials",
                    font = "Dosis Bold 12",
                  },
                  icon = {
                    resource = Resource.bookmark_simple,
                    background = colors.bblack:lighten(10):to_hex(true),
                    stylesheet = string.format("*{fill:#%s;}", colors.white:darken(10):to_hex()),
                  },
                  signal = {
                    on_enter = function(self, _)
                      self:set_bg(colors.black:lighten(10):brighten(10):to_hex(true))
                    end,
                    on_leave = function(self, _)
                      self:set_bg(colors.bblack:lighten(10):to_hex(true))
                    end,
                  },
                }),
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
