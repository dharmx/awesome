local M = {}

local Wibox = require("wibox")
local Awful = require("awful")
local Beautiful = require("beautiful")
local DPI = Beautiful.xresources.apply_dpi
local Resource = require("core.utils.factory").resource_factory()

local enum = require("core.enum")
local EMPTY = enum.modifiers.EMPTY
local SUPER = enum.modifiers.SUPER

M.buttons = map(Awful.button, {
  {
    modifiers = EMPTY,
    button = 1,
    on_press = function(tag) tag:view_only() end,
  },
  {
    modifiers = SUPER,
    button = 1,
    on_press = function(tag)
      if client.focus then client.focus:move_to_tag(tag) end
    end,
  },
  {
    modifiers = EMPTY,
    button = 3,
    on_press = Awful.tag.viewtoggle,
  },
  {
    modifiers = SUPER,
    button = 3,
    on_press = function(tag)
      if client.focus then client.focus:toggle_tag(tag) end
    end,
  },
  {
    modifiers = EMPTY,
    button = 4,
    on_press = function(tag) Awful.tag.viewprev(tag.screen) end,
  },
  {
    modifiers = EMPTY,
    button = 5,
    on_press = function(tag) Awful.tag.viewnext(tag.screen) end,
  },
})

local function update_state(imagebox, tag)
  local clients = #tag:clients()
  if clients > 0 then
    if Awful.screen.focused().selected_tag.index == tag.index then
      imagebox.image = Resource.circle
      imagebox.stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_bg_focus)
      return
    end
    imagebox.image = Resource.circle_dashed
    imagebox.stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_bg_occupied)
  elseif clients == 0 then
    if Awful.screen.focused().selected_tag.index == tag.index then
      imagebox.image = Resource.circle
      imagebox.stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_bg_focus)
      return
    end
    imagebox.image = Resource.circle
    imagebox.stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_bg_empty)
  else
    imagebox.image = Resource.warning_circle
    imagebox.stylesheet = string.format("*{fill:%s;}", Beautiful.taglist_bg_urgent)
  end
end

function M.new(local_screen)
  return {
    screen = local_screen,
    filter = Awful.widget.taglist.filter.all,
    layout = Wibox.layout.fixed.horizontal,
    widget_template = {
      {
        {
          id = "image_role",
          widget = Wibox.widget.imagebox,
        },
        margins = DPI(3),
        widget = Wibox.container.margin,
      },
      bg = Beautiful.taglist_bg,
      shape = Beautiful.taglist_shape,
      widget = Wibox.container.background,
      create_callback = function(self, tag)
        update_state(self:get_children_by_id("image_role")[1], tag)
      end,
      update_callback = function(self, tag)
        update_state(self:get_children_by_id("image_role")[1], tag)
      end,
    },
    buttons = M.buttons,
  }
end

setmetatable(M, { __call = function(self, ...) return self.new(...) end })
return M
