// A simple command-line Pomodoro timer in Swift

import Foundation

let workDuration = 25
let shortBreak = 5
let longBreak = 15
let pomodorosBeforeLongBreak = 4

var pomodoroCount = 0
var isRunning = true

func formatTime(_ seconds: Int) -> String {
    let mins = seconds / 60
    let secs = seconds % 60
    return String(format: "%02d:%02d", mins, secs)
}

func countdown(durationMinutes: Int, label: String) -> Bool {
    let totalSeconds = durationMinutes * 60

    print("\n\(label) - \(durationMinutes) minutes")
    print(String(repeating: "-", count: 30))

    for remaining in stride(from: totalSeconds, through: 1, by: -1) {
        guard isRunning else { return false }
        print("\r  Time remaining: \(formatTime(remaining)) ", terminator: "")
        fflush(stdout)
        Thread.sleep(forTimeInterval: 1.0)
    }

    print("\r  Time remaining: 00:00 ")
    print("\n*** \(label) complete! ***\u{07}")
    return true
}

func cleanup() {
    print("\n\nPomodoro session ended.")
    print("Completed \(pomodoroCount) pomodoro(s). Great work!")
    exit(0)
}

signal(SIGINT) { _ in
    isRunning = false
    cleanup()
}

print(String(repeating: "=", count: 40))
print("       POMODORO TIMER")
print(String(repeating: "=", count: 40))
print("  Work session:  \(workDuration) min")
print("  Short break:   \(shortBreak) min")
print("  Long break:    \(longBreak) min (every \(pomodorosBeforeLongBreak) pomodoros)")
print(String(repeating: "=", count: 40))
print("Press Ctrl+C to stop\n")

while isRunning {
    pomodoroCount += 1
    print("\n[Pomodoro #\(pomodoroCount)]")

    guard countdown(durationMinutes: workDuration, label: "WORK") else { break }

    print("Press Enter to start break...", terminator: "")
    _ = readLine()

    let breakDuration = (pomodoroCount % pomodorosBeforeLongBreak == 0) ? longBreak : shortBreak
    let breakLabel = (pomodoroCount % pomodorosBeforeLongBreak == 0) ? "LONG BREAK" : "SHORT BREAK"

    guard countdown(durationMinutes: breakDuration, label: breakLabel) else { break }

    print("Press Enter to start next pomodoro...", terminator: "")
    _ = readLine()
}

cleanup()
