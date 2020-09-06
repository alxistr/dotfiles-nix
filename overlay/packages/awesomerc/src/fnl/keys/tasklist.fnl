(let [awful (require :awful)
      {: modkey : terminal} (require :keys.generic)]
  [[[] 1
    (fn [c]
      (if (= c client.focus)
        (set c.minimized true)
        (do
          ; without this, the following :isvisible() makes no sense
          (set c.minimized false)
          (when (and (not (c:isvisible)) c.first_tag)
            (c.first_tag:view_only))
          ; This will also un-minimize the client, if needed
          (set client.focus c)
          (c:raise))))]
   [[] 3
    (do
      (var instance nil)
      (fn []
        (if (and instance instance.wibox.visible)
         (do
           (instance:hide)
           (set instance false))
         (set instance (awful.menu.clients {:theme {:width 250}})))))]
   [[] 4
    (fn [] (awful.client.focus.byidx 1))]
   [[] 5
    (fn [] (awful.client.focus.byidx -1))]])
