pcall(require, "luarocks.loader")
P = function(...) print(require("inspect").inspect(...)) end

U = require("lib.std")
F = require("lib.functional")
T = require("lib.tiny")

if_nil = F.if_nil
map = U.table.map
filter = U.table.filter

sum = U.table.sum
any = U.table.any
all = U.table.all
slice = U.table.slice
zip = U.table.zip

split = U.string.split
trim = U.string.trim

require("modules").setup()
