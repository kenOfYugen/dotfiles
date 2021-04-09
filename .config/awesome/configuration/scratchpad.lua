local awful = require("awful")
local bling = require("module.bling")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local music_scratch = bling.module.scratchpad:new{
    command = music,
    rule = {instance = "music"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {
        x = dpi(1308),
        y = dpi(566),
        height = dpi(500),
        width = dpi(600)
    },
    reapply = true,
    dont_focus_before_close = false
}

awesome.connect_signal("scratch::music", function() music_scratch:toggle() end)

local discord_scratch = bling.module.scratchpad:new{
    command = "discord",
    rule = {instance = "discord"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = dpi(460), y = dpi(90), height = dpi(900), width = dpi(1000)},
    reapply = true,
    dont_focus_before_close = false
}

awesome.connect_signal("scratch::discord",
                       function() discord_scratch:toggle() end)
