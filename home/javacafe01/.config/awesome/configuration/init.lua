local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local bling = require("module.bling")

-- Set Autostart Applications
require("configuration.autostart")

-- Default Applications
terminal = "wezterm"
editor = "emacs"
editor_cmd = terminal .. " start " .. os.getenv("EDITOR")
browser = "firefox"
filemanager = "nautilus"
discord = "discord"
launcher = "rofi -show drun"
music = terminal .. " start --class music ncmpcpp"

-- Global Vars
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"

local yy = 10 + beautiful.wibar_height

-- Enable Playerctl Module from Bling
bling.signal.playerctl.enable {
    ignore = {"chromium"},
    backend = "playerctl_lib",
    update_on_activity = true
}

bling.widget.tag_preview.enable {
    show_client_content = false,
    placement_fn = function(c)
        awful.placement.top_left(c, {
            margins = {
                top = beautiful.wibar_height + beautiful.useless_gap / 2,
                left = beautiful.useless_gap / 2
            }
        })
    end,
    scale = 0.15,
    honor_padding = true,
    honor_workarea = false
}

bling.widget.task_preview.enable {
    placement_fn = function(c)
        awful.placement.top(c, {
            margins = {top = beautiful.wibar_height + beautiful.useless_gap / 2}
        })
    end
}

require("module.window_switcher").enable()
-- bling.widget.window_switcher.enable()

-- Set wallpaper
require("module.wallpaper")

-- Get Keybinds
require("configuration.keys")

-- Get Rules
require("configuration.ruled")

-- Layouts and Window Stuff
require("configuration.window")

-- Scratchpad
require("configuration.scratchpad")
