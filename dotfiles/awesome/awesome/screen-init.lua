local awful = require("awful")
--local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
--local lain = require("lain")
--local vicious = require("vicious")
--local json = require("json")
local tags = require("tags")
local bindings = require("bindings")
local battery = require("widgets/battery-widget")
--local hostname = require("hostname")

-- local wallpapers = {
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/w2-right.jpeg",
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/w2-left.jpeg",
--
--     os.getenv("HOME") .. "/.config/awesome/wallpapers/x-left.jpg",
--     os.getenv("HOME") .. "/.config/awesome/wallpapers/x-right.jpg",
--
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/011-left.jpg",
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/011-right.jpg",
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/107-left.jpg",
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/107-right.jpg",
--     -- os.getenv("HOME") .. "/.config/awesome/wallpapers/IMG_209880.jpg",
-- }
--
-- local function set_wallpaper(s)
--     -- Wallpaper
--     for i, wallpaper in ipairs(wallpapers) do
--         if i == s.index then
--           if type(wallpaper) == "function" then
--               wallpaper = wallpaper(s)
--           end
--           gears.wallpaper.centered(wallpaper, s, "#000000")
--         end
--     end
-- end

local function set_wallpaper(s)
    local path = os.getenv("HOME") .. "/.config/awesome/wallpapers/pattern3.png"
    gears.wallpaper.tiled(path, s, "#000000")
end

local function create_top_bar(screen)
    awful.tag(
        tags.filled_dot,
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

--local function create_bottom_bar (screen)
--    local bar = awful.wibar({
--        position = "bottom",
--        opacity = .95,
--        screen = screen
--    })
--
--    local memwidget = wibox.widget.textbox()
--    vicious.cache(vicious.widgets.mem)
--    vicious.register(memwidget, vicious.widgets.mem, "$2MB/$3MB", 3)
--
--    local cpuwidget = awful.widget.graph()
--    cpuwidget:set_width(50)
--    cpuwidget:set_background_color("#494b4f33")
--    cpuwidget:set_color({
--        type = "linear",
--        from = { 0, 0 },
--        to = { 50, 0 },
--        stops = {
--            { 0, "#FF5656" },
--            { 0.5, "#88A175" },
--            { 1, "#AECF96" },
--        }
--    })
--    vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 1)
--
----    local mem = lain.widget.mem({
----        settings = function ()
----            local totalUsed = mem_now.total - mem_now.free
----            local real = totalUsed - (mem_now.cache + mem_now.buf)
----            local txt = string.format("Mem %s[real] %s[used]", real, totalUsed)
----            widget:set_markup(txt)
----        end
----    })
----
----    local cpu = lain.widget.cpu({
----        settings = function ()
----            local parts = {}
----            for index, core in pairs(cpu_now) do
----                if type(core) == 'table' and index > 0 then
----                    parts[index] = string.format("%s[%s]", core.usage, index)
----                end
----            end
----            widget:set_markup("Cpu " .. table.concat(parts, " "))
------            widget:set_markup("Cpu " .. json.stringify(parts))
----        end
----    })
----
----    local net = lain.widget.net({
----        settings = function ()
----            gears.debug.dump(net_now, "net-now")
------            widget:set_markup(json.stringify(fs_now))
----        end
----    })
------    local fs = lain.widget.fs({
------        settings = function ()
------            gears.debug.dump(fs_info, "fs-info")
------            gears.debug.dump(fs_now, "fs-now")
--------            widget:set_markup(json.stringify(fs_now))
------        end
------    })
--
--    bar:setup {
--        layout = wibox.layout.align.horizontal,
--        {
--            layout = wibox.layout.fixed.horizontal,
--            wibox.widget.textbox(hostname),
--            wibox.widget.textbox(" | "),
--            memwidget,
--            wibox.widget.textbox(" | "),
--            cpuwidget,
------            separators.arrow_left("#ffffff"),
----            wibox.widget.textbox(" | "),
----            cpu.widget,
----            wibox.widget.textbox(" | "),
----            mem.widget,
------            wibox.widget.textbox(" | "),
------            fs.widget,
----            wibox.widget.textbox(" | "),
----            net.widget,
--        }
--    }
--
--end

local function init_screen (screen)
    set_wallpaper(screen)
    create_top_bar(screen)
--    if screen.index == 1 then
--        create_bottom_bar(screen)
--    end
end

awful.screen.connect_for_each_screen(init_screen)
