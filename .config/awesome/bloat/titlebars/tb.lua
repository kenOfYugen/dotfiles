-- tb.lua
-- Regular Titlebars
local awful = require("awful")
local gears = require("gears")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local helpers = require("helpers")

-- {{{ Enable THICC Title Bars only while Floating
client.connect_signal("property::floating", function(c)
    local b = false;
    if c.first_tag ~= nil then b = c.first_tag.layout.name == "floating" end
    if c.floating or b then
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
        awful.titlebar.show(c, "right")
        awful.titlebar.show(c, "left")
        c.border_width = dpi(0)
    else
        if not c.bling_tabbed then
            awful.titlebar.hide(c, "top")
            awful.titlebar.hide(c, "bottom")
            awful.titlebar.hide(c, "right")
            awful.titlebar.hide(c, "left")
            c.border_width = dpi(beautiful.border_width)
        end
    end
end)

client.connect_signal("manage", function(c)
    if c.floating or c.first_tag.layout.name == "floating" then
        awful.titlebar.show(c, "top")
        awful.titlebar.show(c, "bottom")
        awful.titlebar.show(c, "right")
        awful.titlebar.show(c, "left")
        c.border_width = dpi(0)
    else
        if not c.bling_tabbed then
            awful.titlebar.hide(c, "top")
            awful.titlebar.hide(c, "bottom")
            awful.titlebar.hide(c, "right")
            awful.titlebar.hide(c, "left")
            c.border_width = dpi(beautiful.border_width)
        end
    end
end)

tag.connect_signal("property::layout", function(t)
    local clients = t:clients()
    for k, c in pairs(clients) do
        if c.floating or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c, "top")
            awful.titlebar.show(c, "bottom")
            awful.titlebar.show(c, "right")
            awful.titlebar.show(c, "left")
            c.border_width = dpi(0)
        else
            if not c.bling_tabbed then
                awful.titlebar.hide(c, "top")
                awful.titlebar.hide(c, "bottom")
                awful.titlebar.hide(c, "right")
                awful.titlebar.hide(c, "left")
                c.border_width = dpi(beautiful.border_width)
            end
        end
    end
end)
-- }}}

-- {{ Helper to create mult tb buttons
local function create_title_button(c, color_focus, color_unfocus)
    local tb_color = wibox.widget {
        forced_width = dpi(8),
        forced_height = dpi(8),
        bg = color_focus,
        shape = gears.shape.circle,
        widget = wibox.container.background
    }

    local tb = wibox.widget {
        tb_color,
        width = 25,
        height = 20,
        strategy = "min",
        layout = wibox.layout.constraint
    }

    local function update()
        if client.focus == c then
            tb_color.bg = color_focus
        else
            tb_color.bg = color_unfocus
        end
    end
    update()
    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    tb:connect_signal("mouse::enter",
                      function() tb_color.bg = color_focus .. "70" end)

    tb:connect_signal("mouse::leave", function() tb_color.bg = color_focus end)

    tb.visible = true
    return tb
end
-- }}

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar

    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        if c.maximized == true then c.maximized = false end
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))
    local borderbuttons = gears.table.join(
                              awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end), awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end))

    local close = create_title_button(c, beautiful.xcolor1, beautiful.xcolor0)
    close:connect_signal("button::press", function() c:kill() end)

    local floating =
        create_title_button(c, beautiful.xcolor5, beautiful.xcolor0)
    floating:connect_signal("button::press",
                            function() c.floating = not c.floating end)

    local min = create_title_button(c, beautiful.xcolor3, beautiful.xcolor0)
    min:connect_signal("button::press", function() c.minimized = true end)

    awful.titlebar(c, {
        position = "top",
        size = beautiful.titlebar_size,
        bg = "#00000000"
    }):setup{
        {
            {
                {
                    nil,
                    nil,
                    {
                        {
                            {
                                min,
                                floating,
                                close,
                                layout = wibox.layout.fixed.horizontal
                            },
                            margins = dpi(10),
                            widget = wibox.container.margin
                        },
                        top = dpi(8),
                        widget = wibox.container.margin

                    },
                    layout = wibox.layout.align.horizontal
                },
                bg = beautiful.xbackground,
                shape = helpers.prrect(beautiful.client_radius, true, true,
                                       false, false),
                widget = wibox.container.background
            },

            top = beautiful.border_width,
            left = beautiful.border_width,
            right = beautiful.border_width,
            widget = wibox.container.margin
        },
        bg = beautiful.xcolor0,
        shape = helpers.prrect(beautiful.client_radius, true, true, false, false),
        widget = wibox.container.background

    }

    awful.titlebar(c, {
        position = "bottom",
        size = beautiful.client_radius * 2,
        bg = "#00000000"
    }):setup{
        {
            {
                bg = beautiful.xbackground,
                shape = helpers.prrect(beautiful.client_radius, false, false,
                                       true, true),
                widget = wibox.container.background
            },
            bottom = beautiful.border_width,
            left = beautiful.border_width,
            right = beautiful.border_width,
            widget = wibox.container.margin
        },

        bg = beautiful.xcolor0,
        shape = helpers.prrect(beautiful.client_radius, false, false, true, true),
        widget = wibox.container.background

    }

    awful.titlebar(c, {
        position = "left",
        size = beautiful.border_width,
        bg = beautiful.xcolor0
    })

    awful.titlebar(c, {
        position = "right",
        size = beautiful.border_width,
        bg = beautiful.xcolor0
    })

end)

-- EOF ------------------------------------------------------------------------
