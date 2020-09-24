--  _ __ ___ 
-- | '__/ __|
-- | | | (__ 
-- |_|  \___|
--
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local helpers = require("helpers")

-- {{{ Autostart

local autostart = require("autostart")

-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- }}}

-- {{{ Variables

theme = "ghosts"
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height
terminal = "st"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
filemanager = "thunar"
discord = "discord"
music = "spotterm -c music -e spt"
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"

-- }}}

-- Set Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/" .. theme ..
                   "/theme.lua")

-- {{{ Import Daemons and Widgets

require("ears")
require("bloat.exitscreen.exitscreen")
require("notifs.notifs")
require("bloat.bar.wibar")

-- }}}

-- {{{ Layouts Table
-- Order matters.

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle, awful.layout.suit.tile,
    awful.layout.suit.floating, awful.layout.suit.fair, awful.layout.suit.max,
    awful.layout.suit.magnifier
}

-- }}}

-- {{{ Menu
-- Create a main menu

local icons = require("icons")
icons.init("sheet")

myawesomemenu = {
    {
        "hotkeys",
        function() hotkeys_popup.show_help(nil, awful.screen.focused()) end
    }, {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart}, {"quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
    items = {
        {"awesome", myawesomemenu, icons.awesome_menu}, {"Terminal", terminal},
        {"Web Browser", browser}, {"File Manager", filemanager}
    }
})

-- }}}

-- {{{ Screen Stuff

awful.screen.connect_for_each_screen(function(s)
    -- Screen padding
    screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}

    -- Each screen has its own tag table.
    awful.tag({"TERM", "FILE", "WEBS", "MUSI", "CHAT"}, s,
              awful.layout.layouts[1])
end)

-- }}}

-- {{{ LayoutList Widget

local ll = awful.widget.layoutlist {
    source = awful.widget.layoutlist.source.default_layouts, -- DOC_HIDE
    spacing = dpi(24),
    base_layout = wibox.widget {
        spacing = dpi(24),
        forced_num_cols = 4,
        layout = wibox.layout.grid.vertical
    },
    widget_template = {
        {
            {
                id = 'icon_role',
                forced_height = dpi(68),
                forced_width = dpi(68),
                widget = wibox.widget.imagebox
            },
            margins = dpi(24),

            widget = wibox.container.margin
        },
        id = 'background_role',
        forced_width = dpi(68),
        forced_height = dpi(68),
        widget = wibox.container.background
    }
}

local layout_popup = awful.popup {
    widget = wibox.widget {
        ll,
        margins = dpi(24),
        widget = wibox.container.margin
    },
    border_color = beautiful.layoutlist_border_color,
    border_width = beautiful.layoutlist_border_width,
    placement = awful.placement.centered,
    ontop = true,
    visible = false,
    bg = beautiful.bg_normal
}

-- }}{

-- {{{ Key Bindings

-- LayoutList

-- Make sure you remove the default `Mod4+Space` and `Mod4+Shift+Space`
-- keybindings before adding this.
function gears.table.iterate_value(t, value, step_size, filter, start_at)
    local k = gears.table.hasitem(t, value, true, start_at)
    if not k then return end

    step_size = step_size or 1
    local new_key = gears.math.cycle(#t, k + step_size)

    if filter and not filter(t[new_key]) then
        for i = 1, #t do
            local k2 = gears.math.cycle(#t, new_key + i)
            if filter(t[k2]) then return t[k2], k2 end
        end
        return
    end

    return t[new_key], new_key
end

awful.keygrabber {
    start_callback = function() layout_popup.visible = true end,
    stop_callback = function() layout_popup.visible = false end,
    export_keybindings = true,
    stop_event = "release",
    stop_key = {"Escape", "Super_L", "Super_R", "Mod4"},
    keybindings = {
        {
            {modkey, "Shift"}, " ", function()
                awful.layout.set(gears.table.iterate_value(ll.layouts,
                                                           ll.current_layout, -1),
                                 nil)
            end
        }, {
            {modkey}, " ", function()
                awful.layout.set(gears.table.iterate_value(ll.layouts,
                                                           ll.current_layout, 1),
                                 nil)
            end
        }
    }
}

-- Mouse bindings

root.buttons(gears.table.join(awful.button({}, 3,
                                           function() mymainmenu:toggle() end),
                              awful.button({}, 4, awful.tag.viewnext),
                              awful.button({}, 5, awful.tag.viewprev)))

-- Key bindings

require("keys")

-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).

awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            size_hints_honor = false,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered + awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    }, {rule = {}, properties = {}, callback = awful.client.setslave}, -- so items in tasklist have the right order 
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
                "Sxiv", "fzfmenu", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui", "veromix", "xtightvncviewer"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },

    -- Add titlebars to normal clients and dialogs (UNCOMMENT FOR DOUBLE BORDERS)
    {
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = true}
    }, -- Set Firefox to always map on the tag named "2" on screen 1.
    --   { rule = { class = "Firefox" },
    --     properties = {  tag = 2 } },
    {
        rule_any = {
            instance = {"scratch"},
            class = {"scratch"},
            icon_name = {"scratchpad_urxvt"}
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = false,
            minimized = true,
            sticky = false,
            width = screen_width * 0.5,
            height = screen_height * 0.5
        },
        callback = function(c)
            awful.placement.centered(c, {
                honor_padding = true,
                honor_workarea = true
            })
            gears.timer.delayed_call(function() c.urgent = false end)
        end
    }
}

-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.

client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus",
                      function(c) c.border_color = beautiful.border_focus end)

client.connect_signal("unfocus",
                      function(c) c.border_color = beautiful.border_normal end)

-- }}}

-- Titlebar related widgets
require("bloat.titlebars.tb")
require("bloat.titlebars.spot-tui")
