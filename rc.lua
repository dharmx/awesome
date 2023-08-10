pcall(require, "luarocks.loader")
local Inspect = require("inspect")
_G.Probe = function(...) print(Inspect.inspect(...)) end

require("modules").setup({
  modules = {
    titlebars = {
      style = "pacman",
    },
  },
})
