(let [awful (require :awful)
      {: modkey : terminal} (require :keys.generic)]
  [[[] 1
    (fn [t] (t:view_only))]
   [[modkey] 1
    (fn [t]
      (when client.focus
        (client.focus:move_to_tag t)))]
   [[] 3
    awful.tag.viewtoggle]
   [[modkey] 3
    (fn [t] (when client.focus (client.focus:toggle_tag t)))]
   [[] 4
    (fn [t] (awful.tag.viewnext t.screen))]
   [[] 5
    (fn [t] (awful.tag.viewprev t.screen))]])
