(let [hotkeys-popup (require :awful.hotkeys_popup)
      freedesktop (require :freedesktop)
      menubar (require :menubar)
      terminal (require :terminal)]
  (-> {:before [["open terminal" terminal]]
       :after [["hotkeys" (fn []
                            [false (hotkeys-popup.widget.show_help)])]
               ["manual" terminal.manual]
               ["edit config" terminal.edit-config]
               ["restart" awesome.restart]
               ["quit" (fn [] (awesome.quit))]]}
      (freedesktop.menu.build)))
