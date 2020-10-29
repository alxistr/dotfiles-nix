(let [awful (require :awful)
      beautiful (require :beautiful)
      menubar (require :menubar)
      inspect (require :inspect)
      {: wallpaper} (require :nix)
      {: global-keys : mouse-buttons} (require :bindings.all)
      {: terminal} (require :terminal)
      rules (require :rules)]

  (require :awful.autofocus)
  (require :signals)

  (beautiful.init (require :themes.gruvbox-light))

  (set menubar.utils.terminal terminal)

  (set awful.layout.layouts (require :layouts))
  (set awful.rules.rules (rules))

  (root.buttons (mouse-buttons))
  (root.keys (global-keys))

  (let [{: set-wallpaper : create-top-bar} (require :screen)]
    (awful.screen.connect_for_each_screen
      (fn [screen]
        (set-wallpaper screen wallpaper)
        (create-top-bar screen)))))
