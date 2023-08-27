---@diagnostic disable: undefined-field
local M = {}

local Gio = require("lgi").Gio
local Wibox = require("wibox")
local Timer = require("gears.timer")

M.polls = {}

---Continuously read a file in intervals.
function M.polls.file(filepath, interval, callback, base_widget)
  -- defaults and asserts
  assert(filepath, "filepath cannot be empty.")
  interval = if_nil(interval, 5)
  base_widget = if_nil(base_widget, Wibox.widget.textbox())
  callback = if_nil(callback, function(widget, data) widget:set_text(data) end)

  local file = Gio.File.new_for_path(filepath)
  assert(file:query_exists(), "filepath must exist.")
  -- only text-based files are allowed
  assert(file:query_file_type({}) == "REGULAR", "filepath must be text-based.")
  local timer = Timer({ timeout = interval })
  timer:connect_signal("timeout", function()
    file:load_contents_async(nil, function(_, results)
      local data, _ = file:load_contents_finish(results)
      -- execute the callback after we have finished reading the file
      if data then callback(base_widget, data) end
      timer:again()
    end)
    timer:stop()
  end)
  timer:start()
  timer:emit_signal("timeout")
  return base_widget, timer
end

---Run a callback in intervals.
function M.polls.callback(callback, interval, base_widget)
  -- defaults and asserts
  interval = if_nil(interval, 5)
  base_widget = if_nil(base_widget, Wibox.widget.textbox())
  callback = assert(callback, "please supply a callback")

  local timer = Timer({ timeout = interval })
  timer:connect_signal("timeout", function()
    callback(base_widget)
    timer:stop()
    timer:again()
  end)
  timer:start()
  timer:emit_signal("timeout")
  return base_widget, timer
end

return M
