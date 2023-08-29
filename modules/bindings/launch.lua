local Menu = require("menubar")
local enum = require("core.enum")
local SUPER = enum.modifiers.SUPER
local CTRL  = enum.modifiers.CTRL
local SHIFT  = enum.modifiers.SHIFT
local scratch = require("core.components.scratch")

return {
  {
    modifiers = SUPER,
    key = "Return",
    description = "Open " .. terminal .. ".",
    on_press = terminal,
  },
  {
    modifiers = SUPER + CTRL,
    key = "Return",
    description = "Open a playground tmux session.",
    on_press = function()
      scratch.new(terminal .. " --class=scratch-tmux -e tmux new-session -A -s playground", "scratch-tmux"):toggle()
    end,
  },
  {
    modifiers = SUPER,
    key = "d",
    description = "Show the menu.",
    on_press = function() Menu.show() end,
  },
  {
    modifiers = SUPER + SHIFT,
    key = "f",
    description = "Open " .. enum.environ.BROWSER .. ".",
    on_press = enum.environ.BROWSER,
  },
  {
    modifiers = SUPER,
    key = "e",
    description = "Open file browsing application.",
    on_press = { terminal, "-e", "ranger" },
  },
  {
    modifiers = CTRL + SHIFT,
    key = "Escape",
    description = "Show the BTOP.",
    on_press = { terminal, "-e", "btop" },
  },
  {
    modifiers = SUPER + SHIFT,
    key = "d",
    description = "Open screenshot popup.",
    on_press = function()
    end,
  },
}
