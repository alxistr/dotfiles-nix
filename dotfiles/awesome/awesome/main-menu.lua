local hotkeys_popup = require("awful.hotkeys_popup").widget
local freedesktop = require("freedesktop")

local man = string.format("%s -e \"man awesome\"", terminal)
-- local edit_cfg = string.format("%s -e \"%s %s\"", terminal, editor, awesome.conffile)

return freedesktop.menu.build({
    before = {
        { "open terminal", terminal },
    },
    after = {
        { "hotkeys", function() return false, hotkeys_popup.show_help end },
        { "manual", man },
        -- { "edit config", edit_cfg },
        { "restart", awesome.restart },
        { "quit", function() awesome.quit() end },
    },
});
