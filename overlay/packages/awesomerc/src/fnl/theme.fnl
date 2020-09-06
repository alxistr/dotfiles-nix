(let [nix (require :nix)
      path (fn [path] (.. nix.static path))
      bg_normal "#000000cc"
      fg_normal "#9e9e9e"
      bg_focus "#242424aa"
      fg_focus "#ebebff"]

  {;:dir nix.path
   :wallpaper nil

   ;;; Styles
   :font "DejaVu Sans Mono Book 8"
   ;:font "Source Code Pro Medium 10"

   ;;; Colors
   : bg_normal
   : fg_normal

   : bg_focus
   : fg_focus

   :bg_urgent "#ffffff"
   :fg_urgent "#000000"

   :bg_systray bg_normal

   ;;; Borders
   :useless_gap 0
   :border_width 1
   :border_normal "#3F3F3F"
   :border_focus "#6F6F6F"
   :border_marked "#CC9393"
   ; :border_width 4
   ; :border_normal "#3F3F3F"
   ; :border_focus "#838383"
   ; :border_marked "#CC9393"

   ;;; Titlebars
   ; :titlebar_bg_focus "#3F3F3F"
   ; :titlebar_bg_normal "#3F3F3F"
   ; :titlebar_bg_focus bg_focus
   ; :titlebar_bg_normal bg_normal
   ; :titlebar_fg_focus fg_focus

   ; There are other variable sets
   ; overriding the default one when
   ; defined, the sets are:
   ; [taglist|tasklist]_[bg|fg]_[focus|urgent]
   ; titlebar_[normal|focus]
   ; tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
   ; Example:
   ; :taglist_bg_focus "#CC9393"

   ; :taglist_fg_focus "#00CCFF"
   ; :tasklist_bg_focus "#222222"
   ; :tasklist_fg_focus "#00CCFF"

   ;;; Taglist
   :taglist_fg_focus "#ffffff"
   :taglist_bg_focus "#444444"

   ;;; Widgets
   ; You can add as many variables as
   ; you wish and access them by using
   ; beautiful.variable in your rc.lua
   ; :fg_widget        "#AECF96"
   ; :fg_center_widget "#88A175"
   ; :fg_end_widget    "#FF5656"
   ; :bg_widget        "#494B4F"
   ; :border_widget    "#3F3F3F"

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
   :titlebar_minimize_button_normal (path "usr/share/awesome/:/default/titlebar/minimize_normal.png")
   :titlebar_minimize_button_focus (path "usr/share/awesome/:/default/titlebar/minimize_focus.png")
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
