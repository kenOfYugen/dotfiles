-- wibar.lua
-- Wibar (top bar)
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")

-- Awesome Panel -----------------------------------------------------------

local awesome_icon = wibox.widget {
    {
        {
            widget = wibox.widget.imagebox,
            image = beautiful.distro_logo,
            resize = true
        },
        margins = dpi(4),
        widget = wibox.container.margin
    },
    shape = helpers.rrect(beautiful.border_radius),
    bg = beautiful.wibar_bg,
    widget = wibox.container.background
}

awesome_icon:buttons(gears.table.join(awful.button({}, 1, function()
    -- gears.surface(s.content):write_to_png("/home/javacafe01/oof.png")
    awesome.emit_signal("panel::open")
end)))

awesome_icon:connect_signal("mouse::enter", function()
    awesome_icon.bg = beautiful.lighter_bg
end)

awesome_icon:connect_signal("mouse::leave",
                            function() awesome_icon.bg = beautiful.wibar_bg end)

-- Battery Bar Widget ---------------------------------------------------------

local battery_icon = wibox.widget {
    font = beautiful.icon_font_name .. "12",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local battery_prog = wibox.widget {
    max_value = 100,
    min_value = 0,
    value = 20,
    forced_height = 3,
    forced_width = 75,
    color = beautiful.xcolor4,
    background_color = beautiful.lighter_bg,
    shape = gears.shape.rounded_bar,
    widget = wibox.widget.progressbar
}

awesome.connect_signal("signal::battery", function(percentage, state)
    local value = percentage

    local bat_icon = ""

    if value >= 0 and value <= 15 then
        bat_icon = ""
    elseif value > 15 and value <= 20 then
        bat_icon = ""
    elseif value > 20 and value <= 30 then
        bat_icon = ""
    elseif value > 30 and value <= 40 then
        bat_icon = ""
    elseif value > 40 and value <= 50 then
        bat_icon = ""
    elseif value > 50 and value <= 60 then
        bat_icon = ""
    elseif value > 60 and value <= 70 then
        bat_icon = ""
    elseif value > 70 and value <= 80 then
        bat_icon = ""
    elseif value > 80 and value <= 90 then
        bat_icon = ""
    elseif value > 90 and value <= 100 then
        bat_icon = ""
    end

    -- if charging
    if state == 1 then bat_icon = "" end

    battery_prog.value = percentage

    battery_icon.markup = "<span foreground='" .. beautiful.xcolor12 .. "'>" ..
                              bat_icon .. "</span>"
end)

-- Volume Bar Widget ---------------------------------------------------------

local volume_icon = wibox.widget {
    font = beautiful.icon_font_name .. "14",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

local volume_prog = wibox.widget {
    max_value = 100,
    min_value = 0,
    value = 20,
    forced_height = 3,
    forced_width = 75,
    color = beautiful.xcolor2,
    background_color = beautiful.lighter_bg,
    shape = gears.shape.rounded_bar,
    widget = wibox.widget.progressbar
}

awesome.connect_signal("signal::volume", function(vol, muted)
    local value = vol or 0

    local vol_icon = ""

    if value >= 77 and value <= 100 then
        vol_icon = ""
    elseif value >= 20 and value < 77 then
        vol_icon = ""
    else
        vol_icon = ""
    end

    if muted then vol_icon = "婢" end

    volume_prog.value = vol

    volume_icon.markup = "<span foreground='" .. beautiful.xcolor2 .. "'>" ..
                             vol_icon .. "</span>"
end)

-- Clock Widget ----------------------------------------------------------------
-- Stolen from No37

local hourtextbox = wibox.widget.textclock("%H")
hourtextbox.markup = helpers.colorize_text(hourtextbox.text, beautiful.xcolor5)
hourtextbox.align = "center"
hourtextbox.valign = "center"

local minutetextbox = wibox.widget.textclock("%M")
minutetextbox.align = "center"
minutetextbox.valign = "center"

hourtextbox:connect_signal("widget::redraw_needed", function()
    hourtextbox.markup = helpers.colorize_text(hourtextbox.text,
                                               beautiful.xcolor5)
end)

minutetextbox:connect_signal("widget::redraw_needed", function()
    minutetextbox.markup = helpers.colorize_text(minutetextbox.text,
                                                 beautiful.xforeground)
end)

awesome.connect_signal("chcolor", function()
    hourtextbox.markup = helpers.colorize_text(hourtextbox.text,
                                               beautiful.xcolor5)
    minutetextbox.markup = helpers.colorize_text(minutetextbox.text,
                                                 beautiful.xforeground)
end)

local clock = wibox.widget {
    {hourtextbox, minutetextbox, layout = wibox.layout.fixed.vertical},
    bg = beautiful.xcolor0 .. "00",
    widget = wibox.container.background
}

local datetooltip = awful.tooltip {};
datetooltip.shape = helpers.prrect(beautiful.border_radius, false, true, true,
                                   false)
datetooltip.preferred_alignments = {"middle", "front", "back"}
datetooltip.mode = "outside"
datetooltip:add_to_object(clock)
datetooltip.text = os.date("%d.%m.%y") -- just don't stay up long enough for that to change

---}}}

-- Systray Widget -------------------------------------------------------------

local mysystray = wibox.widget.systray()
mysystray.base_size = beautiful.systray_icon_size

local mysystray_container = {
    mysystray,
    bottom = dpi(7),
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin
}

-- Tasklist Buttons -----------------------------------------------------------

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                             awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

-- Create the Wibar -----------------------------------------------------------

local final_systray = wibox.widget {
    mysystray_container,
    top = dpi(6),
    left = dpi(3),
    right = dpi(3),
    layout = wibox.container.margin
}

local wrap_widget = function(w)
    return {
        w,
        top = dpi(5),
        left = dpi(3),
        bottom = dpi(5),
        right = dpi(4),
        widget = wibox.container.margin
    }
end

local wrap_widget2 = function(w)
    return {w, left = dpi(20), right = dpi(20), widget = wibox.container.margin}
end

screen.connect_signal("request::desktop_decoration", function(s)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create layoutbox widget
    s.mylayoutbox = awful.widget.layoutbox(s)

    -- Create the wibox
    s.mywibox = wibox({
        -- position = beautiful.wibar_position,
        screen = s,
        type = "dock",
        ontop = true,
        x = 0,
        y = 0,
        width = beautiful.wibar_width,
        height = screen_height,
        visible = true
    })

    s.mypanel = wibox({
        screen = s,
        type = "dock",
        ontop = true,
        x = -400,
        y = 0,
        width = beautiful.panel_width,
        height = screen_height,
        visible = false
    })

    s.mypanel.widget = wibox.widget {
        {
            {
                {
                    require("ui.notifs.notif-center"),
                    forced_height = dpi(875),
                    widget = wibox.container.constraint
                },
                wrap_widget2({
                    volume_prog,
                    direction = "south",
                    widget = wibox.container.rotate
                }),
                helpers.vertical_pad(dpi(30)),
                wrap_widget2({
                    battery_prog,
                    direction = "south",
                    widget = wibox.container.rotate
                }),
                helpers.vertical_pad(dpi(30)),
                wrap_widget2(require("ui.widgets.playerctl")),
                layout = wibox.layout.fixed.vertical
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        bg = beautiful.xbackground,
        widget = wibox.container.background
    }

    s.mywibox:struts{left = beautiful.wibar_width}

    local panel_timed = rubato.timed {
        intro = 0.2,
        duration = 0.4,
        easing = rubato.quadratic,
        subscribed = function(pos)
            if pos <= (beautiful.panel_width * -1) then
                s.mypanel.visible = false
            end
            s.mypanel.x = pos - beautiful.panel_width
            s.mywibox.x = pos
        end
    }

    awesome.connect_signal("panel::open", function()
        if s.mywibox.x == 0 then
            s.mypanel.visible = true
            panel_timed.target = beautiful.panel_width
        else
            panel_timed.target = 0
        end
    end)

    -- Remove wibar on full screen
    local function remove_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = false
        else
            c.screen.mywibox.visible = true
        end
    end

    -- Remove wibar on full screen
    local function add_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = true
        end
    end

    -- Hide bar when a splash widget is visible
    --[[ awesome.connect_signal("widgets::splash::visibility", function(vis)
        screen.primary.mywibox.visible = not vis
    end) ]] --

    client.connect_signal("property::fullscreen", remove_wibar)

    client.connect_signal("request::unmanage", add_wibar)

    -- Create the taglist widget
    s.mytaglist = require("ui.widgets.pacman_taglist")(s)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        bg = beautiful.wibar_bg,
        style = {
            bg = beautiful.xcolor0,
            shape = helpers.rrect(beautiful.border_radius)
        },
        layout = {spacing = dpi(10), layout = wibox.layout.fixed.vertical},
        widget_template = {
            {
                awful.widget.clienticon,
                margins = dpi(6),
                layout = wibox.container.margin
            },
            id = "background_role",
            widget = wibox.container.background,
            create_callback = function(self, c, index, clients)
                self:connect_signal('mouse::enter', function()
                    self.bg_temp = self.bg
                    self.bg = beautiful.xcolor0
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        true, c)
                end)
                self:connect_signal('mouse::leave', function()
                    self.bg = self.bg_temp
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        false, c)
                end)
            end
        }
    }

    -- Add widgets to the wibox
    s.mywibox.widget = wibox.widget {
        {
            layout = wibox.layout.align.vertical,
            expand = "none",
            {
                layout = wibox.layout.fixed.vertical,
                helpers.horizontal_pad(4),
                -- function to add padding
                {
                    {
                        awesome_icon,
                        margins = dpi(3),
                        widget = wibox.container.margin
                    },
                    margins = 3,
                    widget = wibox.container.margin
                },
                wrap_widget({
                    s.mytasklist,
                    left = dpi(5),
                    right = dpi(5),
                    widget = wibox.container.margin
                }),
                s.mypromptbox
            },
            {
                wrap_widget({
                    s.mytaglist,
                    left = dpi(5),
                    right = dpi(5),
                    widget = wibox.container.margin
                }),
                widget = wibox.container.constraint
            },
            {
                wrap_widget(clock),
                wrap_widget(volume_icon),
                wrap_widget(battery_icon),
                wrap_widget(awful.widget.only_on_screen({
                    {
                        final_systray,
                        direction = "west",
                        widget = wibox.container.rotate
                    },
                    left = dpi(4),
                    widget = wibox.container.margin
                }, screen[1])),
                wrap_widget({
                    s.mylayoutbox,
                    top = dpi(5),
                    bottom = dpi(5),
                    right = dpi(8),
                    left = dpi(8),
                    widget = wibox.container.margin
                }),
                helpers.horizontal_pad(4),
                layout = wibox.layout.fixed.vertical
            }
        },
        widget = wibox.container.background,
        bg = beautiful.wibar_bg
    }
end)

-- EOF ------------------------------------------------------------------------
