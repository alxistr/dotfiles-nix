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

  {:layoutbox
   (buttons
     (-> (require :keys.layoutbox)
         (table.unpack)))

   :taglist
   (buttons
     (-> (require :keys.taglist)
         (table.unpack)))

   :tasklist
   (buttons
     (-> (require :keys.tasklist)
         (table.unpack)))

   :mouse
   (buttons
     (-> (require :keys.mouse)
         (table.unpack)))

   :global
   (keys
     (-> (require :keys.global)
         (table.unpack))
     (-> (require :keys.tag)
         (table.unpack)))})

;--[[modkey] "w" (fn [] (mymainmenu:show))
;-- {:description "show main menu" :group "awesome"})

; Menubar
; [{ modkey } "p"
;  function()
;      menubar.show()
;  end
;  {:description "show the menubar" :group "launcher"}]

