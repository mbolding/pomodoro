#!/usr/bin/env lua
-- A simple command-line Pomodoro timer in Lua

local function format_time(seconds)
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", mins, secs)
end

local function countdown(duration_minutes, label)
    local total_seconds = duration_minutes * 60
    print(string.format("\n%s - %d minutes", label, duration_minutes))
    print(string.rep("-", 30))

    for remaining = total_seconds, 1, -1 do
        io.write(string.format("\r  Time remaining: %s ", format_time(remaining)))
        io.flush()

        -- Sleep for 1 second (using os.execute with platform-specific sleep)
        local sleep_cmd
        if package.config:sub(1,1) == '\\' then
            -- Windows
            sleep_cmd = "timeout /t 1 /nobreak >nul 2>&1"
        else
            -- Unix-like (Linux, macOS)
            sleep_cmd = "sleep 1"
        end
        os.execute(sleep_cmd)
    end

    io.write("\r  Time remaining: 00:00 \n")
    print(string.format("\n*** %s complete! ***\a", label))
    return true
end

local function pomodoro()
    local work_duration = 25
    local short_break = 5
    local long_break = 15
    local pomodoros_before_long_break = 4

    print(string.rep("=", 40))
    print("     🍅 POMODORO TIMER (Lua)")
    print(string.rep("=", 40))
    print(string.format("  Work session:  %d min", work_duration))
    print(string.format("  Short break:   %d min", short_break))
    print(string.format("  Long break:    %d min (every %d pomodoros)",
          long_break, pomodoros_before_long_break))
    print(string.rep("=", 40))
    print("Press Ctrl+C to stop\n")

    local pomodoro_count = 0

    while true do
        pomodoro_count = pomodoro_count + 1
        print(string.format("\n[Pomodoro #%d]", pomodoro_count))

        -- Work session
        if not countdown(work_duration, "WORK") then
            break
        end

        io.write("Press Enter to start break...")
        io.read()

        -- Break session
        local is_long_break = (pomodoro_count % pomodoros_before_long_break == 0)
        if is_long_break then
            if not countdown(long_break, "LONG BREAK") then
                break
            end
        else
            if not countdown(short_break, "SHORT BREAK") then
                break
            end
        end

        io.write("Press Enter to start next pomodoro...")
        io.read()
    end

    print(string.format("\nCompleted %d pomodoro(s). Great work! 🎉", pomodoro_count))
end

-- Run the pomodoro timer
pomodoro()
