local os = { getenv = os.getenv }

-- {{{ Main
local theme = {}

theme.dir = os.getenv("HOME") .. "/.config/awesome/theme/"
theme.wallpaper = nil
-- }}}

-- {{{ Styles
theme.font = "DejaVu Sans Mono Book 8"
--theme.font = "Source Code Pro Medium 10"

-- {{{ Colors
--theme.bg_normal = "#242424"
theme.bg_normal = "#000000cc"
theme.fg_normal = "#9e9e9e"

theme.bg_focus = "#242424aa"
theme.fg_focus = "#ebebff"

theme.bg_urgent = "#ffffff"
theme.fg_urgent = "#000000"

theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap = 0
theme.border_width = 1
theme.border_normal = "#3F3F3F"
theme.border_focus = "#6F6F6F"
theme.border_marked = "#CC9393"
--theme.border_width  = 4
--theme.border_normal = "#3F3F3F"
--theme.border_focus  = "#838383"
--theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
--theme.titlebar_bg_focus = "#3F3F3F"
--theme.titlebar_bg_normal = "#3F3F3F"
--theme.titlebar_bg_focus = theme.bg_focus
--theme.titlebar_bg_normal = theme.bg_normal
--theme.titlebar_fg_focus = theme.fg_focus
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

--theme.taglist_fg_focus = "#00CCFF"
--theme.tasklist_bg_focus = "#222222"
--theme.tasklist_fg_focus = "#00CCFF"

-- {{{ Taglist
theme.taglist_fg_focus = "#ffffff"
theme.taglist_bg_focus = "#444444"
-- }}}



-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 20
theme.menu_width  = 150
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme.dir .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = theme.dir .. "/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = nil
theme.menu_submenu_icon      = nil
-- }}}

-- {{{ Layout
theme.layout_tile       = theme.dir .. "/layouts/tile.png"
theme.layout_tileleft   = theme.dir .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.dir .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.dir .. "/layouts/fairv.png"
theme.layout_fairh      = theme.dir .. "/layouts/fairh.png"
theme.layout_spiral     = theme.dir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.dir .. "/layouts/dwindle.png"
theme.layout_max        = theme.dir .. "/layouts/max.png"
theme.layout_fullscreen = theme.dir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme.dir .. "/layouts/magnifier.png"
theme.layout_floating   = theme.dir .. "/layouts/floating.png"
theme.layout_cornernw   = theme.dir .. "/layouts/cornernw.png"
theme.layout_cornerne   = theme.dir .. "/layouts/cornerne.png"
theme.layout_cornersw   = theme.dir .. "/layouts/cornersw.png"
theme.layout_cornerse   = theme.dir .. "/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme.dir .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = "/usr/share/awesome/themes/default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = "/usr/share/awesome/themes/default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = theme.dir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme.dir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme.dir .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme.dir .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
