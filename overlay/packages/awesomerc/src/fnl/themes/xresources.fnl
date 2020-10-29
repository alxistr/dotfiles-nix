(let [shape (require :gears.shape)
      theme-assets (require :beautiful.theme_assets)
      xresources (require :beautiful.xresources)
      dpi xresources.apply_dpi
      default (require :themes.default-dark)
      xrdb (xresources.get_current_theme)
      override (fn [a b]
                 (each [k v (pairs a)]
                   (tset b k v))
                 b)
      darker (fn [color-value darker-n]
               (var result "#")
               (each [s (string.gmatch color-value "[a-fA-F0-9][a-fA-F0-9]")]
                 (let [bg-numeric-value (- (tonumber (.. "0x" s)) darker-n)
                       bg-numeric-value (if (< bg-numeric-value 0)
                                          0
                                          bg-numeric-value)
                       bg-numeric-value (if (> bg-numeric-value 255)
                                          255
                                          bg-numeric-value)]
                   (->> (string.format "%2.2x" bg-numeric-value)
                        (.. result)
                        (set result))))
               result)]

  (-> {:wallpaper nil
       :bg_normal xrdb.background
       :bg_focus xrdb.color12
       :bg_urgent xrdb.color9
       :bg_minimize xrdb.color8
       :bg_systray xrdb.background

       :fg_normal xrdb.foreground
       :fg_focus default.bg_normal
       :fg_urgent default.bg_normal
       :fg_minimize default.bg_normal

       ;:useless_gap (dpi 3)
       ;:border_width (dpi 2)
       :border_color_normal xrdb.color0
       :border_color_active default.bg_focus
       :border_color_marked xrdb.color10

       :tooltip_fg default.fg_normal
       :tooltip_bg default.bg_normal}

       ;:menu_height (dpi 16)
       ;:menu_width (dpi 100)}

      (override default)))

      ; (theme_assets.recolor_layout default.fg_normal)))
      ; (theme-assets.recolor_titlebar default.fg_normal "normal")
      ; (theme-assets.recolor_titlebar (darker default.fg_normal -60) "normal" "hover")
      ; (theme-assets.recolor_titlebar xrdb.color1 "normal" "press")
      ; (theme-assets.recolor_titlebar default.fg_focus "focus")
      ; (theme-assets.recolor_titlebar (darker default.fg_focus -60) "focus" "hover")
      ; (theme-assets.recolor_titlebar xrdb.color1 "focus" "press")))
