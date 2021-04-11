local awful = require("awful")
local bling = require("module.bling")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local awestore = require("awestore")

-- Animations not supported yet

--[[local anim_x = awestore.tweened(-610, {
    duration = 300,
    easing = awestore.easing.cubic_in_out
})]] --

local music_scratch = bling.module.scratchpad:new{
    command = music,
    rule = {instance = "music"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = dpi(10), y = dpi(566), height = dpi(500), width = dpi(600)},
    reapply = true,
    dont_focus_before_close = false
    -- awestore = {x = anim_x}
}

awesome.connect_signal("scratch::music", function() music_scratch:toggle() end)

--[[local anim_y = awestore.tweened(1090, {
    duration = 300,
    easing = awestore.easing.cubic_in_out
})]] --

local term_scratch = bling.module.scratchpad:new{
    command = "wezterm start --class spad",
    rule = {instance = "spad"},
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x = dpi(460), y = dpi(90), height = dpi(900), width = dpi(1000)},
    reapply = true,
    dont_focus_before_close = false
    -- awestore = {y = anim_y}
}

awesome.connect_signal("scratch::term", function() term_scratch:toggle() end)
