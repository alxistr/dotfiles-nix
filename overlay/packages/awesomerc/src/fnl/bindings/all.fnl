(let [awful (require :awful)
      moses (require :moses)

      binding (fn [f]
                (fn [...]
                  (-> [...]
                      (moses.map #(require $))
                      (moses.flatten 1)
                      (moses.map (fn [item]
                                   (f (table.unpack item))))
                      (table.unpack)
                      (awful.util.table.join))))

      buttons (binding awful.button.new)
      keys (binding awful.key.new)

      modkey "Mod4"]

  {:layoutbox-buttons #(buttons :bindings.layoutbox)
   :taglist-buttons #(buttons :bindings.taglist)
   :tasklist-buttons #(buttons :bindings.tasklist)
   :mouse-buttons #(buttons :bindings.mouse)
   :client-buttons #(buttons :bindings.client)
   :client-keys #(keys :bindings.client-keys)
   :global-keys #(keys :bindings.global
                       :bindings.tag)})
