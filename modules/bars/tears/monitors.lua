---@diagnostic disable: unused-local, undefined-field
local M = {}

local Beautiful = require("beautiful")
local Wibox = require("wibox")
local Resource = require("core.utils.factory").resource_factory()
local DPI = require("beautiful.xresources").apply_dpi

local widgets = require("core.components.widgets")
local radial = require("modules.bars.tears.media.radial")

function M.cpu()
  ---@see https://www.baeldung.com/linux/get-cpu-usage
  return widgets.polls.file("/proc/stat", 10, function(self, stat)
    -- total: reduce((accumulate, core) -> accumulate + usage(core), cores)
    -- cores: length(cores)
    -- total * 100 / (cores * 100) => total / cores
    local cores = 0
    local total = 0
    for _, line in ipairs(split(stat, "\n")) do
      if line:match("^cpu[1-9]? ") then
        local cpu = map(tonumber, slice(split(line, " +"), 2))
        local usage = 100 - (cpu[4] * 100 / sum(cpu))
        total = total + usage
        cores = cores + 1
      end
    end
    self:set_value(total / cores)
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
  return widgets.polls.file("/proc/meminfo", 10, function(self, meminfo)
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

return M
