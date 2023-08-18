local M = {}
M._instances = {}
local Bling = require("bling")

function M.new(command, instance_name)
  if not M._instances[instance_name] then
    local instance = Bling.module.scratchpad({
      command = command,
      rule = { instance = instance_name },
      sticky = true,
      autoclose = true,
      floating = true,
      reapply = true,
      dont_focus_before_close = false,
      geometry = { x = 360, y = 90, height = 900, width = 1200 },
    })
    M._instances[instance_name] = instance
  end
  return M._instances[instance_name]
end

return M
