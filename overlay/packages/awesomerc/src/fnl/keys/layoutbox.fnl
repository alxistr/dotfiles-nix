(let [awful (require :awful)
      {: modkey : terminal} (require :keys.generic)]
  [[[] 1 (fn [] (awful.layout.inc 1))]
   [[] 3 (fn [] (awful.layout.inc -1))]
   [[] 4 (fn [] (awful.layout.inc 1))]
   [[] 5 (fn [] (awful.layout.inc -1))]])
