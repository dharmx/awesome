local M = {}

local Path = require("path")

local IconTheme = require("menubar.icon_theme")
local Gio = require("lgi").Gio
local U = require("lib.std")

local if_nil = require("lib.functional").if_nil

function M.stem(path) return U.string.split(Path.basename(path), ".", { plain = true })[1] end

function M.apply_bindings(grouped_bindings, mouse, callback)
  local Awful = require("awful")
  local GT = require("gears.table")

  local function spawn_wrap(cmd) return function() Awful.spawn(cmd) end end
  mouse = if_nil(mouse, false)
  local wrapped_types = { "string", "table" }

  U.table.foreach(if_nil(grouped_bindings, {}), function(group, bindings)
    U.table.foreachi(bindings, function(_, binding)
      binding.group = group
      if GT.hasitem(wrapped_types, type(binding.on_press)) then
        binding.on_press = spawn_wrap(binding.on_press)
      end
      if GT.hasitem(wrapped_types, type(binding.on_release)) then
        binding.on_release = spawn_wrap(binding.on_release)
      end
      if mouse then
        callback(Awful.button(binding))
      else
        callback(Awful.key(binding))
      end
    end)
  end)
end

function M.icon_factory(icon_theme, base)
  local new_icon_theme = IconTheme.new(icon_theme, base)
  return setmetatable({}, {
    __index = function(_, icon_label)
      local kebabed, _ = icon_label:gsub("_", "-")
      return new_icon_theme:find_icon_path(kebabed)
    end,
    __call = function(_, icon_label, icon_size)
      return new_icon_theme:find_icon_path(icon_label, icon_size)
    end,
  })
end

function M.get_current_icon_theme_name()
  ---@diagnostic disable: undefined-field
  local settings = Gio.Settings.new("org.gnome.desktop.interface")
  return settings:get_string("icon-theme")
end

function M.resource_factory()
  local GFS = require("gears.filesystem")
  local resource_path = GFS.get_configuration_dir() .. "resources"
  local function get_file(filename)
    local path = string.format("%s/%s.", resource_path, filename)
    local _, value = U.table.any(function(extension)
      return Path.isfile(path .. extension)
    end, { "svg", "png", "jpeg", "jpg" })
    return path .. value
  end

  return setmetatable({}, {
    ---@param filename string
    __call = function(_, filename)
      return get_file(filename)
    end,
    ---@param filename string
    __index = function(_, filename)
      return get_file((filename:gsub("_", "-")))
    end,
  })
end

return M
