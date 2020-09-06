(let [awful (require :awful)
      {: modkey : terminal} (require :keys.generic)]
  [[[] 3 (fn [] (let [main-menu (require :main-menu)]
                  (main-menu:toggle)))]
   [[] 4 awful.tag.viewnext]
   [[] 5 awful.tag.viewprev]])
