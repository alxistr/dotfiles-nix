(let [awful (require :awful)
      {: modkey : terminal} (require :keys.generic)]
  [[[] 1
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
   [[] 3
    (fn [] (client_menu_toggle_fn))]
   [[] 4
    (fn [] (awful.client.focus.byidx 1))]
   [[] 5
    (fn [] (awful.client.focus.byidx -1))]])
