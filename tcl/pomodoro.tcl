#!/usr/bin/env tclsh

# Configuration
set work_duration 25
set short_break 5
set long_break 15
set pomodoros_before_long_break 4

proc format_time {seconds} {
    set mins [expr {$seconds / 60}]
    set secs [expr {$seconds % 60}]
    return [format "%02d:%02d" $mins $secs]
}

proc countdown {minutes label} {
    set total_seconds [expr {$minutes * 60}]
    puts ""
    puts "$label - $minutes minutes"
    puts "------------------------------"

    for {set i $total_seconds} {$i > 0} {incr i -1} {
        puts -nonewline [format "\r  Time remaining: %s " [format_time $i]]
        flush stdout
        after 1000
    }
    puts -nonewline "\r  Time remaining: 00:00 \n"
    puts ""
    puts "*** $label complete! ***"
    puts "\a" ;# Beep
    flush stdout
}

# Main loop
puts "========================================"
puts "       POMODORO TIMER"
puts "========================================"
puts [format "  Work session:  %d min" $work_duration]
puts [format "  Short break:   %d min" $short_break]
puts [format "  Long break:    %d min (every %d pomodoros)" $long_break $pomodoros_before_long_break]
puts "========================================"
puts "Press Ctrl+C to stop\n"

set pomodoro_count 0

while {1} {
    incr pomodoro_count
    puts ""
    puts "[format {[Pomodoro #%d]} $pomodoro_count]"

    countdown $work_duration "WORK"

    puts -nonewline "Press Enter to start break..."
    flush stdout
    gets stdin

    if {[expr {$pomodoro_count % $pomodoros_before_long_break}] == 0} {
        countdown $long_break "LONG BREAK"
    } else {
        countdown $short_break "SHORT BREAK"
    }

    puts -nonewline "Press Enter to start next pomodoro..."
    flush stdout
    gets stdin
}
