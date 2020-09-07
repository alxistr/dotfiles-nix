(let [awful (require :awful)
      beautiful (require :beautiful)
      menubar (require :menubar)
      inspect (require :inspect)
      {: global-keys : mouse-buttons} (require :bindings.all)
      {: terminal} (require :terminal)
      rules (require :rules)]

  (require :awful.autofocus)
  (require :signals)

  (beautiful.init (require :theme))

  (set menubar.utils.terminal terminal)

  (->> (require :layouts)
       (set awful.layout.layouts))

  (let [{: set-wallpaper : create-top-bar} (require :screen)]
    (awful.screen.connect_for_each_screen
      (fn [screen]
        (set-wallpaper screen "wallpapers/pattern0.png")
        (create-top-bar screen))))

  (root.buttons (mouse-buttons))
  (root.keys (global-keys))

  (set awful.rules.rules (rules)))
