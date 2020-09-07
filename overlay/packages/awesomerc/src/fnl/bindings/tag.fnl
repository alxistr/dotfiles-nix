(let [awful (require :awful)
      moses (require :moses)
      {: modkey} (require :bindings.generic)]
  (-> (moses.range 9)
      (moses.map (fn [index]
                   (let [key (.. "#" (+ index 9))]
                     [; View tag only.
                      [[modkey] key
                       (fn []
                         (let [screen (awful.screen.focused)
                               tag (. screen.tags index)]
                           (when tag
                             (tag:view_only))))
                       {:description (.. "view tag #" index) :group "tag"}]
                      ; Toggle tag display.
                      [[modkey "Control"] key
                       (fn []
                         (let [screen (awful.screen.focused)
                               tag (. screen.tags index)]
                           (when tag
                             (awful.tag.viewtoggle tag))))
                       {:description (.. "toggle tag #" index) :group "tag"}]
                      ; Move client to tag.
                      [[modkey "Shift"] key
                       (fn []
                         (when client.focus
                           (let [tag (. client.focus.screen.tags index)]
                             (when tag
                               (client.focus:move_to_tag tag)))))
                       {:description (.. "move focused client to tag #" index) :group "tag"}]
                      ; Toggle tag on focused client.
                      [[modkey "Control" "Shift"] key
                       (fn []
                         (when client.focus
                           (let [tag (. client.focus.screen.tags index)]
                             (when tag
                               (client.focus:toggle_tag tag)))))
                       {:description (.. "toggle focused client on tag #" index) :group "tag"}]])))
      (moses.flatten 1)))
