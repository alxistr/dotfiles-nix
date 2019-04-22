require("awful.autofocus")
local beautiful = require("beautiful")
local menubar = require("menubar")

require('error-handling')

beautiful.init(require("theme/theme"))

terminal = "termite"
editor = "vim"

require('layouts')

menubar.utils.terminal = terminal

require('signals')
require('screen-init')
require('rules').install()
root.buttons(require('bindings').mouse())
root.keys(require('bindings').global())
