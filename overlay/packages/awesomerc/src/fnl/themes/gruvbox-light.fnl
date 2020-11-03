(let [shape (require :gears.shape)
      nix (require :nix)
      path (fn [path] (.. nix.static path))
      ; font "DejaVu Sans Mono Book 8"
      font "Roboto Mono for Powerline 9"
      bg_normal "#fbf1c7"
      fg_normal "#3c3836"
      bg_focus "#ebdbb2"]

  {:wallpaper nil

   ;;; Styles
   : font

   : bg_normal
   : bg_focus
   :bg_urgent     bg_normal
   :bg_minimize   bg_focus
   :bg_systray    bg_normal
   ; :bg_systray    "#6c6c6c"
   :hotkeys_bg    bg_normal
   : fg_normal
   :fg_focus      fg_normal
   :fg_urgent     "#8f3f71"
   :fg_minimize   fg_normal
   :hotkeys_fg    fg_normal
   :border_normal bg_focus
   :border_focus  "#b16286"
   :border_marked "#cc241d"
   :border_normal "#3F3F3F"
   :border_focus "#6F6F6F"
   :border_marked "#CC9393"
   :titlebar_bg_normal bg_normal
   :titlebar_bg_focus bg_normal

   ;;; Borders
   :useless_gap 0
   :border_width 1
   :border_normal "#3F3F3F"
   :border_focus "#6F6F6F"
   :border_marked "#CC9393"

   ;;; Mouse finder
   :mouse_finder_color "#CC9393"
   ; mouse_finder_[timeout|animate_timeout|radius|factor]

   ; Menu
   ; Variables set for theming the menu:
   ; menu_[bg|fg]_[normal|focus]
   ; menu_[border_color|border_width]
   :menu_height 20
   :menu_width 150

   ;;; Icons

   ;;; Taglist
   :taglist_squares_sel (path "taglist/squarefz.png")
   :taglist_squares_unsel (path "taglist/squarez.png")
   ; :taglist_squares_resize "false"

   ;;; Misc
   :awesome_icon nil
   :menu_submenu_icon nil

   ;;; Layout
   :layout_tile (path "layouts/tile.png")
   :layout_tileleft (path "layouts/tileleft.png")
   :layout_tilebottom (path "layouts/tilebottom.png")
   :layout_tiletop (path "layouts/tiletop.png")
   :layout_fairv (path "layouts/fairv.png")
   :layout_fairh (path "layouts/fairh.png")
   :layout_spiral (path "layouts/spiral.png")
   :layout_dwindle (path "layouts/dwindle.png")
   :layout_max (path "layouts/max.png")
   :layout_fullscreen (path "layouts/fullscreen.png")
   :layout_magnifier (path "layouts/magnifier.png")
   :layout_floating (path "layouts/floating.png")
   :layout_cornernw (path "layouts/cornernw.png")
   :layout_cornerne (path "layouts/cornerne.png")
   :layout_cornersw (path "layouts/cornersw.png")
   :layout_cornerse (path "layouts/cornerse.png")

   ;;; Titlebar
   :titlebar_close_button_focus (path "titlebar/close_focus.png")
   :titlebar_close_button_normal (path "titlebar/close_normal.png")
   ;:titlebar_minimize_button_normal (path "usr/share/awesome/:/default/titlebar/minimize_normal.png")
   ;:titlebar_minimize_button_focus (path "usr/share/awesome/:/default/titlebar/minimize_focus.png")
   :titlebar_ontop_button_focus_active (path "titlebar/ontop_focus_active.png")
   :titlebar_ontop_button_normal_active (path "titlebar/ontop_normal_active.png")
   :titlebar_ontop_button_focus_inactive (path "titlebar/ontop_focus_inactive.png")
   :titlebar_ontop_button_normal_inactive (path "titlebar/ontop_normal_inactive.png")
   :titlebar_sticky_button_focus_active (path "titlebar/sticky_focus_active.png")
   :titlebar_sticky_button_normal_active (path "titlebar/sticky_normal_active.png")
   :titlebar_sticky_button_focus_inactive (path "titlebar/sticky_focus_inactive.png")
   :titlebar_sticky_button_normal_inactive (path "titlebar/sticky_normal_inactive.png")
   :titlebar_floating_button_focus_active (path "titlebar/floating_focus_active.png")
   :titlebar_floating_button_normal_active (path "titlebar/floating_normal_active.png")
   :titlebar_floating_button_focus_inactive (path "titlebar/floating_focus_inactive.png")
   :titlebar_floating_button_normal_inactive (path "titlebar/floating_normal_inactive.png")
   :titlebar_maximized_button_focus_active (path "titlebar/maximized_focus_active.png")
   :titlebar_maximized_button_normal_active (path "titlebar/maximized_normal_active.png")
   :titlebar_maximized_button_focus_inactive (path "titlebar/maximized_focus_inactive.png")
   :titlebar_maximized_button_normal_inactive (path "titlebar/maximized_normal_inactive.png")})
