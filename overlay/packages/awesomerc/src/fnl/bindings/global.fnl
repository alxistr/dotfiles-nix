(let [awful (require :awful)
      hotkeys-popup (require :awful.hotkeys_popup)
      {: terminal} (require :terminal)
      {: modkey} (require :bindings.generic)]

  [[[modkey] "s"
    hotkeys-popup.widget.show_help
    {:description "show help" :group "awesome"}]
   [[modkey "Shift"] "j"
    awful.tag.viewprev
    {:description "view previous" :group "tag"}]
   [[modkey "Shift"] "k"
    awful.tag.viewnext
    {:description "view next" :group "tag"}]
   [[modkey] "Left"
    awful.tag.viewprev
    {:description "view previous" :group "tag"}]
   [[modkey] "Right"
    awful.tag.viewnext
    {:description "view next" :group "tag"}]
   [[modkey] "Escape"
    awful.tag.history.restore
    {:description "go back" :group "tag"}]
   [[modkey] "j"
    (fn [] (awful.client.focus.byidx 1))
    {:description "focus next by index" :group "client"}]
   [[modkey] "k"
    (fn [] (awful.client.focus.byidx -1))
    {:description "focus previous by index" :group "client"}]

   ; Layout manipulation
   [[modkey "Shift"] "j"
    (fn [] (awful.client.swap.byidx 1))
    {:description "swap with next client by index" :group "client"}]
   [[modkey "Shift"] "k"
    (fn [] (awful.client.swap.byidx -1))
    {:description "swap with previous client by index" :group "client"}]
   [[modkey "Control"] "j"
    (fn [] (awful.screen.focus_relative -1))
    {:description "focus the previous screen" :group "screen"}]
   [[modkey "Control"] "k"
    (fn [] (awful.screen.focus_relative 1))
    {:description "focus the next screen" :group "screen"}]
   [[modkey] "u"
    awful.client.urgent.jumpto
    {:description "jump to urgent client" :group "client"}]
   [[modkey] "Tab"
    (fn []
      (awful.client.focus.history.previous)
      (when client.focus
        (client.focus:raise)))
    {:description "go back" :group "client"}]

   ; Standard program
   [[modkey] "Return"
    (fn [] (awful.spawn terminal))
    {:description "open a terminal" :group "launcher"}]
   [[modkey  "Control"] "r"
    awesome.restart
    {:description "reload awesome" :group "awesome"}]
   [[modkey "Shift"] "q"
    awesome.quit
    {:description "quit awesome" :group "awesome"}]

   [[modkey] "l"
    (fn [] (awful.tag.incmwfact 0.05))
    {:description "increase master width factor" :group "layout"}]
   [[modkey] "h"
    (fn [] (awful.tag.incmwfact -0.05))
    {:description "decrease master width factor" :group "layout"}]
   [[modkey "Shift"] "h"
    (fn [] (awful.tag.incnmaster 1 nil true))
    {:description "increase the number of master clients" :group "layout"}]
   [[modkey "Shift"] "l"
    (fn [] (awful.tag.incnmaster -1 nil true))
    {:description "decrease the number of master clients" :group "layout"}]
   [[modkey "Control"] "h"
    (fn [] (awful.tag.incncol 1 nil true))
    {:description "increase the number of columns" :group "layout"}]
   [[modkey "Control"] "l"
    (fn [] (awful.tag.incncol -1 nil true))
    {:description "decrease the number of columns" :group "layout"}]
   [[modkey] "space"
    (fn [] (awful.layout.inc 1))
    {:description "select next" :group "layout"}]
   [[modkey "Shift"] "space"
    (fn [] (awful.layout.inc -1))
    {:description "select previous" :group "layout"}]

   [[modkey "Control"] "n"
    (fn []
      (let [c (awful.client.restore)]
        ; Focus restored client
        (when c
          (set client.focus c)
          (c:raise))))
    {:description "restore minimized" :group "client"}]

   [[modkey "Shift"] "l"
    (fn [] (awful.util.spawn_with_shell "i3lockpp blur -f -e"))
    {:description "lock screen" :group "launcher"}]

   ; Prompt
   [[modkey] "r"
    (fn []
      (let [focused (awful.screen.focused)]
        (focuses.promptbox:run)))
    {:description "run prompt" :group "launcher"}]
   [[modkey] "d"
    (fn [] (awful.spawn "rofi -show run"))
    {:description "run prompt" :group "launcher"}]
   [[modkey] "x"
    (fn []
      (let [focused (awful.screen.focused)
            promptbox focused.promptbox.widget]
        (awful.prompt.run {:prompt       "Run Lua code: "
                           :textbox      promptbox
                           :exe_callback awful.util.eval
                           :history_path (.. (awful.util.get_cache_dir) "/history_eval")})))
    {:description "lua execute prompt" :group "awesome"}]

   ; Screenshots
   [[] "Print"
    (fn [] (awful.util.spawn_with_shell "scrot '%Y-%m-%d-%H%M%S-$wx$h.png' -e 'mv $f ~/images/screenshots'"))
    {:description "Make screenshot" :group "screenshots"}]
   [[modkey "Control"] "s"
    (fn [] (awful.util.spawn_with_shell "sleep 1 && scrot '%Y-%m-%d-%H%M%S-$wx$h.png' -s -e 'mv $f ~/images/screenshots'"))
    {:description "Make screenshot of selected area" :group "screenshots"}]
   [[modkey "Control" "Shift"] "s"
    (fn [] (awful.util.spawn_with_shell "sleep 1 && scrot '%Y-%m-%d-%H%M%S-$wx$h.png' -u -e 'mv $f ~/images/screenshots'"))
    {:description "Make screenshot of focused window" :group "screenshots"}]])
