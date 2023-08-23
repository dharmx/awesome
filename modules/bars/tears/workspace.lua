local M = {}
local Wibox = require("wibox")
local Awful = require("awful")

local U = require("lib.std")
local enum = require("core.enum")
local EMPTY = enum.modifiers.EMPTY
local SUPER = enum.modifiers.SUPER

M.buttons = U.table.map(Awful.button, {
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

function M.new(options)
  return {
    screen = options.screen,
    filter = Awful.widget.taglist.filter.all,
    style = {
    },
    layout = {
      layout = Wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          {
            {
              {
                id = "index_role",
                widget = Wibox.widget.textbox,
              },
              margins = 4,
              widget = Wibox.container.margin,
            },
            widget = Wibox.container.background,
          },
          {
            {
              id = "icon_role",
              widget = Wibox.widget.imagebox,
            },
            margins = 2,
            widget = Wibox.container.margin,
          },
          {
            id = "text_role",
            widget = Wibox.widget.textbox,
          },
          layout = Wibox.layout.fixed.horizontal,
        },
        left = 18,
        right = 18,
        widget = Wibox.container.margin,
      },
      id = "background_role",
      widget = Wibox.container.background,
      create_callback = function(self, c3, _, _)
        self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
        self:connect_signal("mouse::enter", function()
          if self.bg ~= "#FF0000" then
            self.backup = self.bg
            self.has_backup = true
          end
          self.bg = "#FF0000"
        end)
        self:connect_signal("mouse::leave", function()
          if self.has_backup then self.bg = self.backup end
        end)
      end,
      update_callback = function(self, c3, _, _)
        self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
      end,
    },
    buttons = M.buttons,
  }
end

setmetatable(M, {
  __call = function(self, options) return self.new(options) end,
})
return M
