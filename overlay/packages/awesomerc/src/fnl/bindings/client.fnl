(let [awful (require :awful)
      {: modkey} (require :bindings.generic)]
  [[[] 1
    (fn [c]
      (set client.focus c)
      (c:raise))]
   [[modkey] 1 awful.mouse.client.move]
   [[modkey] 3 awful.mouse.client.resize]])
