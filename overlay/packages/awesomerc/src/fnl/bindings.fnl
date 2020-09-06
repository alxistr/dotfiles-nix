(let [awful (require :awful)
      moses (require :moses)

      binding (fn [f]
                (fn [...]
                  (-> (moses.map [...]
                                 (fn [value]
                                   (f (table.unpack value))))
                      (table.unpack)
                      (awful.util.table.join))))

      buttons (binding awful.button.new)
      keys (binding awful.key.new)

      modkey "Mod4"]

  {: modkey

   :layoutbox
   (buttons
     [[] 1 (fn [] (awful.layout.inc 1))]
     [[] 3 (fn [] (awful.layout.inc -1))]
     [[] 4 (fn [] (awful.layout.inc 1))]
     [[] 5 (fn [] (awful.layout.inc -1))])

   :taglist
   (buttons
     [[ ] 1
      (fn [t] (t:view_only))]
     [[ modkey ] 1
      (fn [t]
        (when client.focus
          (client.focus:move_to_tag t)))]
     [[ ] 3
      awful.tag.viewtoggle]
     [[ modkey ] 3
      (fn [t] (when client.focus (client.focus:toggle_tag t)))]
     [[ ] 4
      (fn [t] (awful.tag.viewnext t.screen))]
     [[ ] 5
      (fn [t] (awful.tag.viewprev t.screen))])

   :tasklist
   (buttons
     [{ } 1
      (fn [c]
        (if (= c client.focus)
          (set c.minimized true)
          (do
            ; Without this, the following :isvisible() makes no sense
            (set c.minimized false)
            (when (and (not (c:isvisible)) c.first_tag)
              (c.first_tag:view_only))
            ; This will also un-minimize the client, if needed
            (set client.focus c)
            (c:raise))))]
     [{ } 3
      (fn [] (client_menu_toggle_fn))]
     [{ } 4
      (fn [] (awful.client.focus.byidx 1))]
     [{ } 5
      (fn [] (awful.client.focus.byidx -1))])

   :mouse
   (buttons
     [{ } 3 (fn [] (let [main-menu (require :main-menu)]
                     (main-menu:toggle)))]
     [{ } 4 awful.tag.viewnext]
     [{ } 5 awful.tag.viewprev])

   :global
   (keys)})
