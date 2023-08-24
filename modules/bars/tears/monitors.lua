local M = {}

local widgets = require("core.components.widgets")
local radial = require("modules.bars.tears.media.radial")

local Resource = require("core.utils.factory").resource_factory()
local DPI = require("beautiful.xresources").apply_dpi

function M.cpu(colors)
  return widgets.poll_file("/proc/stat", 2, function(self, stat)
    local cpu = split(split(stat, "\n", { plain = true })[1], " ", { plain = true })
    cpu = slice(cpu, 2)
    cpu = map(tonumber, cpu)
    local new_value = 100 - ((cpu[4] * 100) / (cpu[1] + cpu[2] + cpu[3] + cpu[4] + cpu[5] + cpu[6] + cpu[7] + cpu[8] + cpu[9]))
    self:set_value(new_value)
  end, radial({
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
  }))
end

function M.ram(colors)
  return widgets.poll_file("/proc/meminfo", 2, function(self, meminfo)
    local ram = {}
    U.table.foreachi(split(trim(meminfo), "\n"), function(_, line)
      local splits = split(line, ": +", { plain = false })
      ram[splits[1]] = tonumber(split(splits[2], " ", { plain = true })[1])
    end)
    local new_value = (ram.MemTotal - ram.MemFree - ram.Buffers - ram.Cached) / 1024 ^ 2
    self:set_value(new_value)
  end, radial({
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
  }))
end

return M
