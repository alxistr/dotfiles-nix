(let [awful (require :awful)
      gears (require :gears)
      wibox (require :wibox)
      battery (require :widgets.battery-widget)
      nix (require :nix)

      tags (require :tags)

      {: taglist-buttons
       : tasklist-buttons
       : layoutbox-buttons} (require :bindings.all)

      with-layout (fn [layout ...]
                    (let [value [...]]
                      (tset value :layout layout)
                      value))]

  {:set-wallpaper
   (fn [screen path]
     (-> (.. nix.static path)
         (gears.wallpaper.tiled s "#000000")))

   :create-top-bar
   (fn [screen]
     (awful.tag tags.black-meduim-small-square
                screen
                (. awful.layout.layouts 1))

     (set screen.promptbox (awful.widget.prompt))

     (let [layoutbox (awful.widget.layoutbox screen)
           taglist (awful.widget.taglist screen
                                         awful.widget.taglist.filter.all
                                         (bindings.taglist-buttons))
           tasklist (awful.widget.tasklist screen
                                           awful.widget.tasklist.filter.currenttags
                                           (bindings.tasklist-buttons))
           bar (awful.wibar {:position "top"
                             :opacity .9
                             :screen screen
                             :height 20})
           clock (wibox.widget.textclock "%Y-%m-%d %a %H:%M " 1)]
       (layoutbox:buttons (bindings.layoutbox-buttons))

       (bar:setup (with-layout
                    wibox.layout.align.horizontal
                    (with-layout wibox.layout.fixed.horizontal
                                 taglist
                                 screen.promptbox)
                    tasklist
                    (if (= screen.index 1)
                      (with-layout wibox.layout.fixed.horizontal
                                   (wibox.widget.systray)
                                   (battery {:battery_prefix " "
                                             :limits {}})
                                   (awful.widget.keyboardlayout)
                                   clock
                                   layoutbox)
                      (with-layout wibox.layout.fixed.horizontal
                                   clock
                                   layoutbox))))))})
