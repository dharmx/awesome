---@diagnostic disable: undefined-field
local M = {}

local F = require("lib.functional")
local Gio = require("lgi").Gio

local Wibox = require("wibox")
local Timer = require("gears.timer")

function M.poll_file(filepath, interval, callback, base_widget)
  assert(filepath, "filepath cannot be empty.")
  interval = F.if_nil(interval, 5)
  base_widget = F.if_nil(base_widget, Wibox.widget.textbox())
  callback = F.if_nil(callback, function(widget, data) widget:set_text(data) end)

  local file = Gio.File.new_for_path(filepath)
  assert(file:query_exists(), "filepath must exist.")
  assert(file:query_file_type({}) == "REGULAR", "filepath must be text-based.")
  local timer = Timer({ timeout = interval })
  timer:connect_signal("timeout", function()
    file:load_contents_async(nil, function(_, results)
      local data, _ = file:load_contents_finish(results)
      if data then callback(base_widget, data) end
      timer:again()
    end)
    timer:stop()
  end)
  timer:start()
  timer:emit_signal("timeout")
  return base_widget, timer
end

return M
