(let [awful (require :awful)
      moses (require :moses)

      binding (fn [f]
                (fn [...]
                  (-> [...]
                      (moses.flatten 1)
                      (moses.map (fn [item]
                                   (f (table.unpack item))))
                      (table.unpack)
                      (awful.util.table.join))))

      buttons (binding awful.button.new)
      keys (binding awful.key.new)

      modkey "Mod4"]

  {:layoutbox-buttons #(buttons (require :bindings.layoutbox))
   :taglist-buttons #(buttons (require :bindings.taglist))
   :tasklist-buttons #(buttons (require :bindings.tasklist))
   :mouse-buttons #(buttons (require :bindings.mouse))
   :client-buttons #(buttons (require :bindings.client))
   :client-keys #(keys (require :bindings.client-keys))
   :global-keys #(keys (require :bindings.global)
                       (require :bindings.tag))})
