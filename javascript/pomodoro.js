#!/usr/bin/env node

function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`;
}

function startTimer(duration, type, callback) {
    let secondsRemaining = duration * 60;
    console.log(`\nStarting ${type}: ${formatTime(secondsRemaining)}`);

    const interval = setInterval(() => {
        secondsRemaining--;
        process.stdout.write(`\r${type}: ${formatTime(secondsRemaining)}`);

        if (secondsRemaining <= 0) {
            clearInterval(interval);
            console.log(`\n${type} finished!`);
            callback();
        }
    }, 1000);
}

function pomodoro() {
    let pomodorosCompleted = 0;
    const workDuration = 25; // minutes
    const shortBreakDuration = 5; // minutes
    const longBreakDuration = 15; // minutes
    const longBreakInterval = 4; // pomodoros

    const runSession = () => {
        startTimer(workDuration, 'Work Session', () => {
            pomodorosCompleted++;
            console.log(`Pomodoros completed: ${pomodorosCompleted}`);

            if (pomodorosCompleted % longBreakInterval === 0) {
                startTimer(longBreakDuration, 'Long Break', runSession);
            } else {
                startTimer(shortBreakDuration, 'Short Break', runSession);
            }
        });
    };

    runSession();
}

// Start the Pomodoro timer
pomodoro();
