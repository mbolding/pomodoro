#!/bin/bash
# A simple command-line Pomodoro timer

WORK_DURATION=25
SHORT_BREAK=5
LONG_BREAK=15
POMODOROS_BEFORE_LONG_BREAK=4

format_time() {
    local seconds=$1
    printf "%02d:%02d" $((seconds / 60)) $((seconds % 60))
}

countdown() {
    local duration_minutes=$1
    local label=$2
    local total_seconds=$((duration_minutes * 60))

    echo ""
    echo "$label - $duration_minutes minutes"
    echo "------------------------------"

    for ((remaining = total_seconds; remaining > 0; remaining--)); do
        printf "\r  Time remaining: $(format_time $remaining) "
        sleep 1
    done

    printf "\r  Time remaining: 00:00 \n"
    echo ""
    echo "*** $label complete! ***"
    printf '\a'
    return 0
}

cleanup() {
    echo ""
    echo ""
    echo "Pomodoro session ended."
    echo "Completed $pomodoro_count pomodoro(s). Great work!"
    exit 0
}

trap cleanup SIGINT

echo "========================================"
echo "       POMODORO TIMER"
echo "========================================"
echo "  Work session:  $WORK_DURATION min"
echo "  Short break:   $SHORT_BREAK min"
echo "  Long break:    $LONG_BREAK min (every $POMODOROS_BEFORE_LONG_BREAK pomodoros)"
echo "========================================"
echo "Press Ctrl+C to stop"
echo ""

pomodoro_count=0

while true; do
    ((pomodoro_count++))
    echo ""
    echo "[Pomodoro #$pomodoro_count]"

    countdown $WORK_DURATION "WORK"

    read -p "Press Enter to start break..."

    if ((pomodoro_count % POMODOROS_BEFORE_LONG_BREAK == 0)); then
        countdown $LONG_BREAK "LONG BREAK"
    else
        countdown $SHORT_BREAK "SHORT BREAK"
    fi

    read -p "Press Enter to start next pomodoro..."
done
