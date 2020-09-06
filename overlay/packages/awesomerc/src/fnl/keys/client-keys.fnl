(let [awful (require :awful)
      {: modkey} (require :keys.generic)]
  [[[modkey] "f"
    (fn [c]
      (set c.fullscreen (not c.fullscreen))
      (c:raise))
    {:description  "toggle fullscreen" :group  "client"}]

   [[modkey "Shift"] "c"
    (fn [c]
      (c:kill))
    {:description  "close" :group  "client"}]

   [[modkey "Control"] "space"
    awful.client.floating.toggle
    {:description  "toggle floating" :group  "client"}]

   [[modkey "Control"] "Return"
    (fn [c]
      (c:swap (awful.client.getmaster)))
    {:description  "move to master" :group  "client"}]

   [[modkey] "o"
    (fn [c]
      (c:move_to_screen))
    {:description  "move to screen" :group  "client"}]

   [[modkey] "t"
    (fn [c]
      (set c.ontop (not c.ontop)))
    {:description  "toggle keep on top" :group  "client"}]

   [[modkey] "n"
    (fn [c]
      ; The client currently has the input focus, so it cannot be
      ; minimized, since minimized clients can't have the focus.
      (set c.minimized true))
    {:description  "minimize" :group  "client"}]

   [[modkey] "m"
    (fn [c]
      (set c.maximized (not c.maximized))
      (c:raise))
    {:description  "maximize" :group  "client"}]])
