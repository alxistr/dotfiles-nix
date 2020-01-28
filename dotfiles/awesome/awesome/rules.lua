local awful = require("awful")
local beautiful = require("beautiful")
local bindings = require("bindings")

local rules = {}

rules.install = function ()
    -- {{{ Rules
    -- Rules to apply to new clients (through the "manage" signal).
    awful.rules.rules = {
        -- All clients will match this rule.
        { rule = { },
          properties = { border_width = beautiful.border_width,
                         border_color = beautiful.border_normal,
                         focus = awful.client.focus.filter,
                         raise = true,
                         keys = bindings.clientkeys(),
                         buttons = bindings.clientbuttons(),
                         screen = awful.screen.preferred,
                         placement = awful.placement.no_overlap+awful.placement.no_offscreen
         }
        },

        -- Floating clients.
        { rule_any = {
            instance = {
              "DTA",  -- Firefox addon DownThemAll.
              "copyq",  -- Includes session name in class.
            },
            class = {
              "Arandr",
              "Gpick",
              "Kruler",
              "MessageWin",  -- kalarm.
              "Sxiv",
              "Wpa_gui",
              "pinentry",
              "veromix",
              "xtightvncviewer"},

            name = {
              "Event Tester",  -- xev.
            },
            role = {
              "AlarmWindow",  -- Thunderbird's calendar.
              -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
          }, properties = { floating = true }},

        -- $ xprop WM_CLASS
        -- Add titlebars to normal clients and dialogs
        { rule_any = {type = { "normal", "dialog" } },
          properties = { titlebars_enabled = true } },

        -- { rule = { class = "Skype" },
        --   properties = { screen = 2, tag = "ι" } },
        -- { rule = { class = "skypeforlinux" },
        --   properties = { screen = 2, tag = "ι" } },
        -- { rule = { class = "qTox" },
        --   properties = { screen = 2, tag = "ι" } },
        -- { rule = { class = "Icedove" },
        --   properties = { screen = 2, tag = "θ" } },
        { rule_any = { class = { "keepassx", "Keepassx" } },
          properties = { opacity = .95 } },
        { rule_any = { class = { "code", "Code" } },
          properties = { opacity = .9 } },
        { rule_any = { class = { "xterm", "XTerm", "UXTerm" } },
          properties = { opacity = .95 } },
        { rule_any = { class = { "termite", "Termite"} },
          properties = { opacity = .9 } },
        { rule_any = { class = { "x-terminal-emulator", "X-terminal-emulator"} },
          properties = { opacity = .95 } },
        { rule_any = { class = { "nautilus", "Nautilus" } },
          properties = { opacity = .9 } },
        { rule_any = { class = { "thunar", "Thunar" } },
          properties = { opacity = .9 } },
        { rule_any = { class = { "sublime_text", "Sublime_text" } },
          properties = { opacity = .95 } },
        { rule_any = { class = { "jetbrains-idea" } },
          properties = { opacity = .95 } },
        { rule_any = { class = { "jetbrains-pycharm" } },
          properties = { opacity = .95 } },
        { rule_any = { class = { "Emacs" } },
          properties = { opacity = .9 } },
        -- { rule = { class = "Liferea" },
        --   properties = { screen = 2, tag = "ψ" } },

        -- Set Firefox to always map on the tag named "2" on screen 1.
        -- { rule = { class = "Firefox" },
        --   properties = { screen = 1, tag = "2" } },
    }
    -- }}}
end

return rules
