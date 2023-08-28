---@diagnostic disable: unused-local, undefined-field
local M = {}

local Beautiful = require("beautiful")
local Resource = require("core.utils.factory").resource_factory()
local DPI = require("beautiful.xresources").apply_dpi

local widgets = require("core.components.widgets")
local radial = require("modules.bars.tears.media.radial")

function M.cpu()
  return widgets.polls.file("/proc/stat", 2, function(self, stat)
    local cpu = split(split(stat, "\n", { plain = true })[1], " ", { plain = true })
    cpu = slice(cpu, 2)
    cpu = map(tonumber, cpu)
    local new_value = 100 - ((cpu[4] * 100) / (cpu[1] + cpu[2] + cpu[3] + cpu[4] + cpu[5] + cpu[6] + cpu[7] + cpu[8] + cpu[9]))
    self:set_value(new_value)
  end, radial({
    background = Beautiful.radial_cpu_bg,
    radial = {
      background = Beautiful.radial_cpu_arc_bg,
      foreground = Beautiful.radial_cpu_arc_fg,
      body_background = Beautiful.radial_cpu_arc_body_bg,
      forced_width = DPI(33),
    },
    icon = {
      resource = Resource.cpu_duotone,
      stylesheet = string.format("*{fill:%s;}", Beautiful.radial_cpu_icon_stroke),
    },
    max_value = 100,
    min_value = 0,
  }))
end

function M.ram()
  return widgets.polls.file("/proc/meminfo", 2, function(self, meminfo)
    local ram = {}
    U.table.foreachi(split(trim(meminfo), "\n"), function(_, line)
      local splits = split(line, ": +", { plain = false })
      ram[splits[1]] = tonumber(split(splits[2], " ", { plain = true })[1])
    end)
    local new_value = (ram.MemTotal - ram.MemFree - ram.Buffers - ram.Cached) / 1024 ^ 2
    self:set_value(new_value)
  end, radial({
    background = Beautiful.radial_ram_bg,
    radial = {
      background = Beautiful.radial_ram_arc_bg,
      foreground = Beautiful.radial_ram_arc_fg,
      body_background = Beautiful.radial_ram_arc_body_bg,
      forced_width = DPI(33),
    },
    icon = {
      resource = Resource.disc_duotone,
      stylesheet = string.format("*{fill:%s;}", Beautiful.radial_ram_icon_stroke),
    },
    max_value = 16,
    min_value = 0,
  }))
end

function M.battery()
  awesome.connect_signal("signal::battery", function(percentage, state)
  end)
end

return M
