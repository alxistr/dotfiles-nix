(let [hotkeys-popup (require :awful.hotkeys_popup)
      freedesktop (require :freedesktop)
      menubar (require :menubar)
      {: terminal} menubar.utils]

  (-> {:before [["open terminal" terminal]]
       :after [["hotkeys" (fn []
                            [false hotkeys-popup.widget.show_help])]
               ["manual" (string.format "%s -e \"man awesome\""
                                         terminal)]
               ["edit config" (string.format "%s -e \"%s %s\""
                                             terminal
                                             "vim"
                                             awesome.conffile)]
               ["restart" awesome.restart]
               ["quit" (fn [] (awesome.quit))]]}
      (freedesktop.menu.build)))

