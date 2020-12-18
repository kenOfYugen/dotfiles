--  _   _                         
-- | |_| |__   ___ _ __ ___   ___ 
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|
local awful = require("awful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gears = require("gears")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local helpers = require("helpers")

-- Inherit default theme

local theme = dofile(themes_path .. "default/theme.lua")

-- Titlebar icon path

local icon_path = gears.filesystem.get_configuration_dir() .. "icons/"

-- Icons for Notif Center

theme.clear_icon = icon_path .. "notif-center/clear.png"
theme.clear_grey_icon = icon_path .. "notif-center/clear_grey.png"
theme.notification_icon = icon_path .. "notif-center/notification.png"
theme.delete_icon = icon_path .. "notif-center/delete.png"
theme.delete_grey_icon = icon_path .. "notif-center/delete_grey.png"

-- Load ~/.Xresources colors and set fallback colors

theme.xbackground = xrdb.background or "#2f343f"
theme.xforeground = xrdb.foreground or "#d8dee8"
theme.xcolor0 = xrdb.color0 or "#4b5262"
theme.xcolor1 = xrdb.color1 or "#bf616a"
theme.xcolor2 = xrdb.color2 or "#a3be8c"
theme.xcolor3 = xrdb.color3 or "#ebcb8b"
theme.xcolor4 = xrdb.color4 or "#81a1c1"
theme.xcolor5 = xrdb.color5 or "#b48ead"
theme.xcolor6 = xrdb.color6 or "#89d0bA"
theme.xcolor7 = xrdb.color7 or "#e5e9f0"
theme.xcolor8 = xrdb.color8 or "#434a5a"
theme.xcolor9 = xrdb.color9 or "#b3555e"
theme.xcolor10 = xrdb.color10 or "#93ae7c"
theme.xcolor11 = xrdb.color11 or "#dbbb7b"
theme.xcolor12 = xrdb.color12 or "#7191b1"
theme.xcolor13 = xrdb.color13 or "#a6809f"
theme.xcolor14 = xrdb.color14 or "#7dbba8"
theme.xcolor15 = xrdb.color15 or "#d1d5dc"

-- Fonts

theme.font = "JetBrains Mono 9"
theme.icon_font = "FiraCode Nerd Font Mono 18"
theme.font_taglist = "FiraCode Nerd Font Mono 13"
theme.max_font = "FiraCode Nerd Font Mono 10"

-- Background Colors

theme.bg_dark = theme.xcolor0
theme.bg_normal = theme.xbackground
theme.bg_focus = theme.xcolor8
theme.bg_urgent = theme.xcolor8
theme.bg_minimize = theme.xcolor8

-- Foreground Colors

theme.fg_normal = theme.xcolor7
theme.fg_focus = theme.xcolor4
theme.fg_urgent = theme.xcolor3
theme.fg_minimize = theme.xcolor8

theme.button_close = theme.xcolor1

-- Borders

theme.border_width = dpi(2)
theme.border_normal = theme.xcolor0
theme.border_focus = theme.xcolor0
theme.border_radius = dpi(10)
theme.client_radius = dpi(10)
theme.widget_border_width = dpi(2)
theme.widget_border_color = theme.xcolor0

-- Taglist

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
                                taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
                                  taglist_square_size, theme.fg_normal)
theme.taglist_font = theme.font_taglist
theme.taglist_bg = theme.wibar_bg
theme.taglist_bg_focus = theme.xbackground .. "00"
theme.taglist_fg_focus = theme.xcolor4
theme.taglist_bg_urgent = theme.wibar_bg
theme.taglist_fg_urgent = theme.xcolor1
theme.taglist_bg_occupied = theme.wibar_bg
theme.taglist_fg_occupied = theme.xcolor6
theme.taglist_bg_empty = theme.wibar_bg
theme.taglist_fg_empty = theme.xcolor8
theme.taglist_bg_volatile = transparent
theme.taglist_fg_volatile = theme.xcolor11
theme.taglist_disable_icon = true

-- Tasklist

theme.tasklist_font = theme.font
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.xbackground
theme.tasklist_fg_focus = theme.xcolor6
theme.tasklist_bg_minimize = theme.xbackground .. "70"
theme.tasklist_fg_minimize = theme.xforeground .. "70"
theme.tasklist_bg_normal = theme.xbackground
theme.tasklist_fg_normal = theme.xforeground
theme.tasklist_disable_task_name = false
theme.tasklist_disable_icon = true
theme.tasklist_bg_urgent = theme.xbackground
theme.tasklist_fg_urgent = theme.xcolor1
theme.tasklist_spacing = dpi(5)
theme.tasklist_align = "center"

-- Titlebars

theme.titlebar_size = dpi(40)
theme.titlebar_bg_focus = theme.xbackground
theme.titlebar_bg_normal = theme.xbackground
theme.titlebar_fg_focus = theme.xbackground
theme.titlebar_fg_normal = theme.xbackground

-- Edge snap

theme.snap_bg = theme.xcolor4
theme.snap_shape = helpers.rrect(theme.border_radius)

-- Prompts

theme.prompt_bg = transparent
theme.prompt_fg = theme.xforeground

-- Tooltips

theme.tooltip_bg = theme.xcolor0
theme.tooltip_fg = theme.xforeground
theme.tooltip_font = theme.font
theme.tooltip_border_width = theme.border_width
theme.tooltip_border_color = theme.xcolor0
theme.tooltip_opacity = 1
theme.tooltip_align = "left"

-- Menu

theme.menu_font = theme.font
theme.menu_bg_focus = theme.xcolor4
theme.menu_fg_focus = theme.xcolor7
theme.menu_bg_normal = theme.xbackground
theme.menu_fg_normal = theme.xcolor7
theme.menu_submenu_icon = gears.filesystem.get_configuration_dir() ..
                              "theme/icons/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width = dpi(130)
theme.menu_border_color = "#0000000"
theme.menu_border_width = theme.border_width

-- Hotkeys Pop Up

theme.hotkeys_font = theme.font
theme.hotkeys_border_color = theme.xcolor0

-- Layout List

theme.layoutlist_border_color = theme.xcolor8
theme.layoutlist_border_width = theme.border_width
-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.xforeground)

-- Gaps

theme.useless_gap = dpi(5)

-- Exit Screen

theme.exit_screen_fg = theme.xforeground

-- Wibar

theme.wibar_height = dpi(30)
theme.wibar_margin = dpi(15)
theme.wibar_spacing = dpi(15)
theme.wibar_bg = theme.xcolor0

-- Systray

theme.systray_icon_spacing = dpi(10)
theme.bg_systray = theme.xbackground
theme.systray_icon_size = dpi(15)

-- Collision

theme.collision_focus_bg = theme.xcolor8
theme.collision_focus_fg = theme.xcolor6
theme.collision_focus_shape = helpers.rrect(theme.border_radius)
theme.collision_focus_border_width = theme.border_width
theme.collision_focus_border_color = theme.border_normal

theme.collision_focus_bg_center = theme.xcolor8
theme.collision_shape_width = dpi(50)
theme.collision_shape_height = dpi(50)
theme.collision_focus_shape_center = gears.shape.circle

theme.collision_max_bg = theme.xbackground
theme.collision_max_fg = theme.xcolor8
theme.collision_max_shape = helpers.rrect(theme.border_radius)
theme.bg_urgent = theme.xcolor1

theme.collision_resize_width = dpi(20)
theme.collision_resize_shape = theme.collision_focus_shape
theme.collision_resize_border_width = theme.collision_focus_border_width
theme.collision_resize_border_color = theme.collision_focus_border_color
theme.collision_resize_padding = dpi(5)
theme.collision_resize_bg = theme.collision_focus_bg
theme.collision_resize_fg = theme.collision_focus_fg

theme.collision_screen_shape = theme.collision_focus_shape
theme.collision_screen_border_width = theme.collision_focus_border_width
theme.collision_screen_border_color = theme.collision_focus_border_color
theme.collision_screen_padding = dpi(5)
theme.collision_screen_bg = theme.xbackground
theme.collision_screen_fg = theme.xcolor4
theme.collision_screen_bg_focus = theme.xcolor8
theme.collision_screen_fg_focus = theme.xcolor4

-- Tabs

theme.mstab_bar_height = dpi(40)
theme.mstab_bar_padding = dpi(0)
theme.mstab_tabbar_orientation = "top"
theme.mstab_border_radius = dpi(6)
theme.tabbar_style = "modern"
theme.tabbar_bg_focus = theme.xbackground
theme.tabbar_bg_normal = theme.xcolor0
theme.mstab_bar_ontop = true

theme.notification_spacing = 10

return theme
