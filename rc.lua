pcall(require, "luarocks.loader")
P = function(...) print(require("inspect").inspect(...)) end
require("modules").setup()
