local awful = require("awful")
--local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
--local lain = require("lain")
--local vicious = require("vicious")
local tags = require("tags")
local bindings = require("bindings")
local battery = require("widgets/battery-widget")

local function set_wallpaper(s)
    local path = os.getenv("HOME") .. "/.config/awesome/wallpapers/pattern16.png"
    gears.wallpaper.tiled(path, s, "#000000")
end

local function create_top_bar(screen)
    awful.tag(
        tags.black_meduim_small_square,
        screen,
        awful.layout.layouts[1]
    )

    screen.promptbox = awful.widget.prompt()

    local layoutbox = awful.widget.layoutbox(screen)
    layoutbox:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)
    ))

    local taglist = awful.widget.taglist(
        screen,
        awful.widget.taglist.filter.all,
        bindings.taglist_buttons()
    )

    local tasklist = awful.widget.tasklist(
        screen,
        awful.widget.tasklist.filter.currenttags,
        bindings.tasklist_buttons()
    )

    local bar = awful.wibar({
        position = "top",
        opacity = .9,
        screen = screen,
        height = 20,
    })

    local clock = wibox.widget.textclock("%Y-%m-%d %a %H:%M ", 1)
    --lain.widget.calendar.attach(clock)

    local right
    if screen.index == 1 then
        right = {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            battery{
                battery_prefix = ' ',
                limits = {}
            },
            awful.widget.keyboardlayout(),
            clock,
            layoutbox
        }
    else
        right = {
            layout = wibox.layout.fixed.horizontal,
            clock,
            layoutbox
        }
    end

    bar:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            taglist,
            screen.promptbox,
        },
        tasklist,
        right
    }

end

local function init_screen (screen)
    set_wallpaper(screen)
    create_top_bar(screen)
end

awful.screen.connect_for_each_screen(init_screen)
