package main

import (
	"bufio"
	"fmt"
	"os"
	"os/signal"
	"syscall"
	"time"
)

const (
	workDuration    = 25 * time.Minute
	shortBreak      = 5 * time.Minute
	longBreak       = 15 * time.Minute
	pomodorosPerSet = 4
)

func main() {
	printBanner()
	runPomodoro()
}

func printBanner() {
	fmt.Println("========================================")
	fmt.Println("       🍅 POMODORO TIMER (Go)")
	fmt.Println("========================================")
	fmt.Printf("  Work session:  %d min\n", int(workDuration.Minutes()))
	fmt.Printf("  Short break:   %d min\n", int(shortBreak.Minutes()))
	fmt.Printf("  Long break:    %d min (every %d pomodoros)\n", int(longBreak.Minutes()), pomodorosPerSet)
	fmt.Println("========================================")
	fmt.Println("Press Ctrl+C to stop\n")
}

func runPomodoro() {
	pomodoroCount := 0
	reader := bufio.NewReader(os.Stdin)

	// Setup signal handling for graceful shutdown
	sigChan := make(chan os.Signal, 1)
	signal.Notify(sigChan, os.Interrupt, syscall.SIGTERM)

	for {
		pomodoroCount++
		fmt.Printf("\n[Pomodoro #%d]\n", pomodoroCount)

		// Work session
		if !countdown(workDuration, "WORK", sigChan) {
			fmt.Printf("\n\nPomodoro session ended.\n")
			fmt.Printf("Completed %d pomodoro(s). Great work! 🎉\n", pomodoroCount)
			return
		}

		fmt.Print("Press Enter to start break...")
		reader.ReadString('\n')

		// Break session
		var breakDuration time.Duration
		var breakLabel string
		if pomodoroCount%pomodorosPerSet == 0 {
			breakDuration = longBreak
			breakLabel = "LONG BREAK"
		} else {
			breakDuration = shortBreak
			breakLabel = "SHORT BREAK"
		}

		if !countdown(breakDuration, breakLabel, sigChan) {
			fmt.Printf("\n\nPomodoro session ended.\n")
			fmt.Printf("Completed %d pomodoro(s). Great work! 🎉\n", pomodoroCount)
			return
		}

		fmt.Print("Press Enter to start next pomodoro...")
		reader.ReadString('\n')
	}
}

func countdown(duration time.Duration, label string, sigChan chan os.Signal) bool {
	fmt.Printf("\n%s - %d minutes\n", label, int(duration.Minutes()))
	fmt.Println("------------------------------")

	// Create ticker for countdown updates
	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()

	// Calculate end time
	endTime := time.Now().Add(duration)

	for {
		select {
		case <-sigChan:
			// Handle interrupt signal
			fmt.Println()
			return false

		case now := <-ticker.C:
			remaining := endTime.Sub(now)

			if remaining <= 0 {
				// Timer complete
				fmt.Print("\r  Time remaining: 00:00 ")
				fmt.Printf("\n\n*** %s complete! ***\a\n", label)
				return true
			}

			// Display countdown
			minutes := int(remaining.Minutes())
			seconds := int(remaining.Seconds()) % 60
			fmt.Printf("\r  Time remaining: %02d:%02d ", minutes, seconds)
		}
	}
}
