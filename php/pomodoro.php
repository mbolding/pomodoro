#!/usr/bin/env php
<?php
/**
 * A simple command-line Pomodoro timer in PHP.
 */

const WORK_DURATION = 25;
const SHORT_BREAK = 5;
const LONG_BREAK = 15;
const POMODOROS_BEFORE_LONG_BREAK = 4;

$pomodoroCount = 0;
$isRunning = true;

// Setup signal handler for Ctrl+C
pcntl_signal(SIGINT, function() {
    global $pomodoroCount, $isRunning;
    $isRunning = false;
    echo "\n\nPomodoro session ended.\n";
    echo "Completed {$pomodoroCount} pomodoro(s). Great work!\n";
    exit(0);
});

function formatTime($seconds) {
    $mins = intdiv($seconds, 60);
    $secs = $seconds % 60;
    return sprintf("%02d:%02d", $mins, $secs);
}

function countdown($durationMinutes, $label) {
    global $isRunning;
    $totalSeconds = $durationMinutes * 60;

    echo "\n{$label} - {$durationMinutes} minutes\n";
    echo "------------------------------\n";

    for ($remaining = $totalSeconds; $remaining > 0 && $isRunning; $remaining--) {
        pcntl_signal_dispatch(); // Check for signals
        $timeStr = formatTime($remaining);
        echo "\r  Time remaining: {$timeStr} ";
        flush();
        sleep(1);
    }

    echo "\r  Time remaining: 00:00 \n";
    echo "\n*** {$label} complete! ***\a\n";
    return $isRunning;
}

function waitForEnter($message) {
    echo $message;
    flush();
    fgets(STDIN);
}

// Main program
echo "========================================\n";
echo "       POMODORO TIMER\n";
echo "========================================\n";
echo "  Work session:  " . WORK_DURATION . " min\n";
echo "  Short break:   " . SHORT_BREAK . " min\n";
echo "  Long break:    " . LONG_BREAK . " min (every " . POMODOROS_BEFORE_LONG_BREAK . " pomodoros)\n";
echo "========================================\n";
echo "Press Ctrl+C to stop\n\n";

while ($isRunning) {
    $pomodoroCount++;
    echo "\n[Pomodoro #{$pomodoroCount}]\n";

    if (!countdown(WORK_DURATION, "WORK")) break;

    waitForEnter("Press Enter to start break...");

    if ($pomodoroCount % POMODOROS_BEFORE_LONG_BREAK === 0) {
        if (!countdown(LONG_BREAK, "LONG BREAK")) break;
    } else {
        if (!countdown(SHORT_BREAK, "SHORT BREAK")) break;
    }

    waitForEnter("Press Enter to start next pomodoro...");
}

echo "\n\nPomodoro session ended.\n";
echo "Completed {$pomodoroCount} pomodoro(s). Great work!\n";
