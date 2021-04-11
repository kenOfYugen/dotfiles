local awful = require("awful")

local lock_screen = {}

local lua_pam_path = os.getenv("HOME") .. "/.config/awesome/liblua_pam.so"

lock_screen.init = function()
    -- See if lua pam is installed
    awful.spawn.easy_async_with_shell("stat " .. lua_pam_path ..
                                          " >/dev/null 2>&1",
                                      function(_, __, ___, exitcode)
        if exitcode == 0 then
            local pam = require("liblua_pam")
            lock_screen.authenticate = function(password)
                return pam.auth_current_user(password)
            end
        else
            -- Default pass
            lock_screen.authenticate = function(password)
                return password == "awesomewm"
            end
        end
        require("ui.lockscreen.lockscreen")
    end)
end

return lock_screen
