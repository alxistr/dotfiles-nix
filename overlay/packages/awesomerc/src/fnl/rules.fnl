; $ xprop WM_CLASS

(let [awful (require :awful)
      beautiful (require :beautiful)
      {: client-buttons : client-keys} (require :bindings.all)]

  #[{; All clients will match this rule.
     :rule {}
     :properties {:border_width beautiful.border_width
                  :border_color beautiful.border_normal
                  :focus awful.client.focus.filter
                  :raise true
                  :keys (client-keys)
                  :buttons (client-buttons)
                  :screen awful.screen.preferred
                  :placement (+ awful.placement.no_overlap
                                awful.placement.no_offscreen)}}

    {; Floating clients.
     :rule_any {:instance ["DTA" ; Firefox addon DownThemAll.
                           "copyq"] ; Includes session name in class.
                :class ["Arandr"
                        "Gpick"
                        "Kruler"
                        "MessageWin"  ; kalarm.
                        "Sxiv"
                        "Wpa_gui"
                        "pinentry"
                        "veromix"
                        "xtightvncviewer"]
                :name ["Event Tester"] ; xev
                :role ["AlarmWindow"]} ; Thunderbird's calendar.
                       ; "pop-up"]} ; e.g. Google Chrome's (detached) Developer Tools.
     :properties {:floating true}}

    {; Add titlebars to normal clients and dialogs
     :rule_any {:type ["normal" "dialog"]}
     :properties {:titlebars_enabled true}}

    {:rule_any {:class ["code" "Code"
                        "keepassx" "Keepassx"
                        "sublime_text" "Sublime_text"
                        "jetbrains-idea"
                        "jetbrains-pycharm"
                        "xterm" "XTerm" "UXTerm"
                        "x-terminal-emulator" "X-terminal-emulator"]}
     :properties {:opacity .95}}

    {:rule_any {:class ["termite" "Termite"
                        "nautilus" "Nautilus"
                        "thunar" "Thunar"
                        "Emacs"]}
     :properties {:opacity .9}}])
