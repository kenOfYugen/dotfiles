--             _            _             _   
--   __ _ _   _| |_ ___  ___| |_ __ _ _ __| |_ 
--  / _` | | | | __/ _ \/ __| __/ _` | '__| __|
-- | (_| | |_| | || (_) \__ \ || (_| | |  | |_ 
--  \__,_|\__,_|\__\___/|___/\__\__,_|_|   \__|
local awful = require("awful")

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then findme = cmd:sub(0, firstspace - 1) end
    awful.spawn.with_shell(string.format(
                               'pgrep -u $USER -x %s > /dev/null || (%s)',
                               findme, cmd), false)
end

-- Network Manager Applet
-- run_once("nm-applet")

-- Compositor
run_once("~/.bin/phicom2")

-- Disable Bell
run_once("xset -b")

-- Mpd Cleanup
run_once([[
    ps aux | grep "mpc idleloop player" | grep -v grep | awk '{print $2}' | xargs kill
    ]])

return autostart
