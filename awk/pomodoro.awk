#!/usr/bin/awk -f

function format_time(seconds,    m, s) {
    m = int(seconds / 60)
    s = seconds % 60
    return sprintf("%02d:%02d", m, s)
}

function countdown(minutes, label,    total_seconds, i) {
    total_seconds = minutes * 60
    printf "\n%s - %d minutes\n", label, minutes
    print "------------------------------"
    
    for (i = total_seconds; i > 0; i--) {
        printf "\r  Time remaining: %s ", format_time(i)
        fflush() # Ensure output is printed immediately
        system("sleep 1")
    }
    printf "\r  Time remaining: 00:00 \n"
    printf "\n*** %s complete! ***\a\n", label
    fflush()
}

BEGIN {
    # Configuration
    work_duration = 25
    short_break = 5
    long_break = 15
    pomodoros_before_long_break = 4

    # Title Banner
    print "========================================"
    print "       POMODORO TIMER"
    print "========================================"
    printf "  Work session:  %d min\n", work_duration
    printf "  Short break:   %d min\n", short_break
    printf "  Long break:    %d min (every %d pomodoros)\n", long_break, pomodoros_before_long_break
    print "========================================"
    print "Press Ctrl+C to stop\n"

    pomodoro_count = 0

    while (1) {
        pomodoro_count++
        printf "\n[Pomodoro #%d]\n", pomodoro_count
        
        countdown(work_duration, "WORK")

        printf "Press Enter to start break..."
        if ((getline < "-") <= 0) exit # Exit on EOF or error

        if (pomodoro_count % pomodoros_before_long_break == 0) {
            countdown(long_break, "LONG BREAK")
        } else {
            countdown(short_break, "SHORT BREAK")
        }

        printf "Press Enter to start next pomodoro..."
        if ((getline < "-") <= 0) exit 
    }
}
