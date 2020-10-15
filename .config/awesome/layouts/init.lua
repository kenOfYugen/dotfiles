local awful = require("awful")
local beautiful = require("beautiful")

awful.layout.layouts = {
    awful.layout.suit.tile, awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating, awful.layout.suit.fair, awful.layout.suit.max,
    awful.layout.suit.magnifier, awful.layout.suit.corner.nw
}
