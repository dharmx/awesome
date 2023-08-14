local M = {}

local Gears = require("gears")
local Awful = require("awful")
local Path = require("path")

local IconTheme = require("menubar.icon_theme")
local Gio = require("lgi").Gio
local U = require("lib.std")

local if_nil = require("lib.functional").if_nil

function M.stem(path) return U.string.split(Path.basename(path), ".", { plain = true })[1] end

function M.apply_bindings(grouped_bindings, mouse, callback)
  local function spawn_wrap(cmd) return function() Awful.spawn(cmd) end end
  mouse = if_nil(mouse, false)
  local wrapped_types = { "string", "table" }
  U.table.foreach(if_nil(grouped_bindings, {}), function(group, bindings)
    U.table.foreachi(bindings, function(_, binding)
      binding.group = group
      if Gears.table.hasitem(wrapped_types, type(binding.on_press)) then
        binding.on_press = spawn_wrap(binding.on_press)
      end
      if Gears.table.hasitem(wrapped_types, type(binding.on_release)) then
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

return M
