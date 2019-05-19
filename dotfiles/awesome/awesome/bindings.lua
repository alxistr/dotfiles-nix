local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local bindings = {}

bindings.modkey = "Mod4"

bindings.global = function ()
    local globalkeys

    -- {{{ Key bindings
    globalkeys = awful.util.table.join(
        awful.key({ bindings.modkey }, "s",
                  hotkeys_popup.show_help,
                  { description = "show help", group = "awesome" }),
        awful.key({ bindings.modkey, "Shift" }, "j",
                  awful.tag.viewprev,
                  { description = "view previous", group = "tag" }),
        awful.key({ bindings.modkey, "Shift" }, "k",
                  awful.tag.viewnext,
                  { description = "view next", group = "tag" }),
        awful.key({ bindings.modkey }, "Left",
                  awful.tag.viewprev,
                  { description = "view previous", group = "tag" }),
        awful.key({ bindings.modkey }, "Right",
                  awful.tag.viewnext,
                  { description = "view next", group = "tag" }),
        awful.key({ bindings.modkey }, "Escape",
                  awful.tag.history.restore,
                  { description = "go back", group = "tag" }),

        awful.key({ bindings.modkey }, "j",
                  function()
                      awful.client.focus.byidx(1)
                  end,
                  { description = "focus next by index", group = "client" }),
        awful.key({ bindings.modkey, }, "k",
                  function()
                      awful.client.focus.byidx(-1)
                  end,
                  { description = "focus previous by index", group = "client" }),
        --        awful.key({ bindings.modkey,           }, "w", function () mymainmenu:show() end,
        --                  {description = "show main menu", group = "awesome"}),

        -- Layout manipulation
        awful.key({ bindings.modkey, "Shift" }, "j",
                  function ()
                      awful.client.swap.byidx(1)
                  end,
                  {description = "swap with next client by index", group = "client"}),
        awful.key({ bindings.modkey, "Shift" }, "k",
                  function ()
                      awful.client.swap.byidx(-1)
                  end,
                  {description = "swap with previous client by index", group = "client"}),
        awful.key({ bindings.modkey, "Control" }, "j",
                  function ()
                      awful.screen.focus_relative(1)
                  end,
                  {description = "focus the next screen", group = "screen"}),
        awful.key({ bindings.modkey, "Control" }, "k",
                  function ()
                      awful.screen.focus_relative(-1)
                  end,
                  {description = "focus the previous screen", group = "screen"}),
        awful.key({ bindings.modkey}, "u",
                  awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = "client"}),
        awful.key({ bindings.modkey}, "Tab",
                  function ()
                      awful.client.focus.history.previous()
                      if client.focus then
                          client.focus:raise()
                      end
                  end,
                  {description = "go back", group = "client"}),

        -- Standard program
        awful.key({ bindings.modkey }, "Return",
                  function ()
                      awful.spawn(terminal)
                  end,
                  {description = "open a terminal", group = "launcher"}),
        awful.key({ bindings.modkey, "Control"}, "r",
                  awesome.restart,
                  {description = "reload awesome", group = "awesome"}),
        awful.key({ bindings.modkey, "Shift"}, "q",
                  awesome.quit,
                  {description = "quit awesome", group = "awesome"}),

        awful.key({ bindings.modkey }, "l",
                  function ()
                      awful.tag.incmwfact( 0.05)
                  end,
                  {description = "increase master width factor", group = "layout"}),
        awful.key({ bindings.modkey }, "h",
                  function ()
                      awful.tag.incmwfact(-0.05)
                  end,
                  {description = "decrease master width factor", group = "layout"}),
        awful.key({ bindings.modkey, "Shift" }, "h",
                  function ()
                      awful.tag.incnmaster( 1, nil, true)
                  end,
                  {description = "increase the number of master clients", group = "layout"}),
        awful.key({ bindings.modkey, "Shift" }, "l",
                  function ()
                      awful.tag.incnmaster(-1, nil, true)
                  end,
                  {description = "decrease the number of master clients", group = "layout"}),
        awful.key({ bindings.modkey, "Control" }, "h",
                  function ()
                      awful.tag.incncol( 1, nil, true)
                  end,
                  {description = "increase the number of columns", group = "layout"}),
        awful.key({ bindings.modkey, "Control" }, "l",
                  function ()
                      awful.tag.incncol(-1, nil, true)
                  end,
                  {description = "decrease the number of columns", group = "layout"}),
        awful.key({ bindings.modkey}, "space",
                  function ()
                      awful.layout.inc( 1)
                  end,
                  {description = "select next", group = "layout"}),
        awful.key({ bindings.modkey, "Shift" }, "space",
                  function ()
                      awful.layout.inc(-1)
                  end,
                  {description = "select previous", group = "layout"}),

        awful.key({ bindings.modkey, "Control" }, "n",
                  function ()
                      local c = awful.client.restore()
                      -- Focus restored client
                      if c then
                          client.focus = c
                          c:raise()
                      end
                  end,
                  {description = "restore minimized", group = "client"}),

        awful.key({ bindings.modkey, "Shift" }, "l",
                  function ()
                      awful.util.spawn_with_shell("i3lockpp blur -f -e")
                  end,
                  {description = "lock screen", group = "launcher"}),

        -- Prompt
        awful.key({ bindings.modkey }, "r",
                  function ()
                      awful.screen.focused().promptbox:run()
                  end,
                  {description = "run prompt", group = "launcher"}),
        awful.key({ bindings.modkey }, "d",
                  function ()
                      awful.spawn("rofi -show run")
                  end,
                  {description = "run prompt", group = "launcher"}),

        awful.key({ bindings.modkey }, "x",
                  function ()
                      awful.prompt.run {
                        prompt       = "Run Lua code: ",
                        textbox      = awful.screen.focused().promptbox.widget,
                        exe_callback = awful.util.eval,
                        history_path = awful.util.get_cache_dir() .. "/history_eval"
                      }
                  end,
                  {description = "lua execute prompt", group = "awesome"}),

        -- Menubar
        -- awful.key({ bindings.modkey }, "p",
        --           function()
        --               menubar.show()
        --           end,
        --           {description = "show the menubar", group = "launcher"}),

        -- Screenshots
        awful.key({ }, "Print",
                  function ()
                      awful.util.spawn_with_shell("scrot '%Y-%m-%d-%H%M%S-$wx$h.png' -e 'mv $f ~/images/screenshots'")
                  end,
                  {description = "Make screenshot", group = "screenshots"}),

        awful.key({ bindings.modkey, "Control" }, "s",
            function ()
                awful.util.spawn_with_shell("sleep 1 && scrot '%Y-%m-%d-%H%M%S-$wx$h.png' -s -e 'mv $f ~/images/screenshots'")
            end,
            {description = "Make screenshot of selected area", group = "screenshots"}),

        awful.key({ bindings.modkey, "Control", "Shift" }, "s",
            function ()
                awful.util.spawn_with_shell("sleep 1 && scrot '%Y-%m-%d-%H%M%S-$wx$h.png' -u -e 'mv $f ~/images/screenshots'")
            end,
            {description = "Make screenshot of focused window", group = "screenshots"})

    )

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it works on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        globalkeys = awful.util.table.join(globalkeys,
            -- View tag only.
            awful.key({ bindings.modkey }, "#" .. i + 9,
                      function ()
                            local screen = awful.screen.focused()
                            local tag = screen.tags[i]
                            if tag then
                               tag:view_only()
                            end
                      end,
                      {description = "view tag #"..i, group = "tag"}),
            -- Toggle tag display.
            awful.key({ bindings.modkey, "Control" }, "#" .. i + 9,
                      function ()
                          local screen = awful.screen.focused()
                          local tag = screen.tags[i]
                          if tag then
                             awful.tag.viewtoggle(tag)
                          end
                      end,
                      {description = "toggle tag #" .. i, group = "tag"}),
            -- Move client to tag.
            awful.key({ bindings.modkey, "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:move_to_tag(tag)
                              end
                         end
                      end,
                      {description = "move focused client to tag #"..i, group = "tag"}),
            -- Toggle tag on focused client.
            awful.key({ bindings.modkey, "Control", "Shift" }, "#" .. i + 9,
                      function ()
                          if client.focus then
                              local tag = client.focus.screen.tags[i]
                              if tag then
                                  client.focus:toggle_tag(tag)
                              end
                          end
                      end,
                      {description = "toggle focused client on tag #" .. i, group = "tag"})
        )
    end

    return globalkeys

end

bindings.clientkeys = function ()
    local clientkeys

    clientkeys = awful.util.table.join(
        awful.key({ bindings.modkey }, "f",
                  function (c)
                      c.fullscreen = not c.fullscreen
                      c:raise()
                  end,
                  {description = "toggle fullscreen", group = "client"}),
        awful.key({ bindings.modkey, "Shift" }, "c",
                  function (c)
                      c:kill()
                  end,
                  {description = "close", group = "client"}),
        awful.key({ bindings.modkey, "Control" }, "space",
                  awful.client.floating.toggle,
                  {description = "toggle floating", group = "client"}),
        awful.key({ bindings.modkey, "Control" }, "Return",
                  function (c)
                      c:swap(awful.client.getmaster())
                  end,
                  {description = "move to master", group = "client"}),
        awful.key({ bindings.modkey }, "o",
                  function (c)
                      c:move_to_screen()
                  end,
                  {description = "move to screen", group = "client"}),
        awful.key({ bindings.modkey }, "t",
                  function (c)
                      c.ontop = not c.ontop
                  end,
                  {description = "toggle keep on top", group = "client"}),
        awful.key({ bindings.modkey }, "n",
                  function (c)
                      -- The client currently has the input focus, so it cannot be
                      -- minimized, since minimized clients can't have the focus.
                      c.minimized = true
                  end ,
                  {description = "minimize", group = "client"}),
        awful.key({ bindings.modkey }, "m",
                  function (c)
                      c.maximized = not c.maximized
                      c:raise()
                  end ,
                  {description = "maximize", group = "client"})
    )

    return clientkeys

end

bindings.clientbuttons = function ()
    local clientbuttons

    clientbuttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ bindings.modkey }, 1, awful.mouse.client.move),
        awful.button({ bindings.modkey }, 3, awful.mouse.client.resize))

    return clientbuttons

end

-- Create a wibox for each screen and add it
bindings.taglist_buttons = function ()
    return awful.util.table.join(
        awful.button({ }, 1,
                     function(t)
                         t:view_only()
                     end),
        awful.button({ bindings.modkey }, 1,
                     function(t)
                         if client.focus then
                             client.focus:move_to_tag(t)
                         end
                     end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ bindings.modkey }, 3,
                     function(t)
                         if client.focus then
                             client.focus:toggle_tag(t)
                         end
                     end),
        awful.button({ }, 4,
                     function(t)
                         awful.tag.viewnext(t.screen)
                     end),
        awful.button({ }, 5,
                     function(t)
                         awful.tag.viewprev(t.screen)
                     end)
    )
end

local function client_menu_toggle_fn()
    local instance = nil
    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

bindings.tasklist_buttons = function ()
    return awful.util.table.join(
         awful.button({ }, 1,
                      function (c)
                          if c == client.focus then
                              c.minimized = true
                          else
                              -- Without this, the following
                              -- :isvisible() makes no sense
                              c.minimized = false
                              if not c:isvisible() and c.first_tag then
                                  c.first_tag:view_only()
                              end
                              -- This will also un-minimize
                              -- the client, if needed
                              client.focus = c
                              c:raise()
                          end
                      end),
         awful.button({ }, 3, client_menu_toggle_fn()),
         awful.button({ }, 4,
                      function ()
                          awful.client.focus.byidx(1)
                      end),
         awful.button({ }, 5,
                      function ()
                          awful.client.focus.byidx(-1)
                      end)
    )
end

bindings.mouse = function ()
    return awful.util.table.join(
        awful.button({ }, 3, function () require('main-menu'):toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    )
end

return bindings
