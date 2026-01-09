#!/usr/bin/env python3
"""A simple command-line Pomodoro timer."""

import time
import sys


def format_time(seconds):
    """Format seconds as MM:SS."""
    mins, secs = divmod(seconds, 60)
    return f"{mins:02d}:{secs:02d}"


def countdown(duration_minutes, label):
    """Run a countdown timer with the given duration."""
    total_seconds = duration_minutes * 60
    print(f"\n{label} - {duration_minutes} minutes")
    print("-" * 30)

    try:
        for remaining in range(total_seconds, 0, -1):
            sys.stdout.write(f"\r  Time remaining: {format_time(remaining)} ")
            sys.stdout.flush()
            time.sleep(1)

        print(f"\r  Time remaining: 00:00 ")
        print(f"\n*** {label} complete! ***\a")
        return True
    except KeyboardInterrupt:
        print("\n\nTimer stopped.")
        return False


def pomodoro():
    """Run the Pomodoro timer."""
    work_duration = 25
    short_break = 5
    long_break = 15
    pomodoros_before_long_break = 4

    print("=" * 40)
    print("       POMODORO TIMER")
    print("=" * 40)
    print(f"  Work session:  {work_duration} min")
    print(f"  Short break:   {short_break} min")
    print(f"  Long break:    {long_break} min (every {pomodoros_before_long_break} pomodoros)")
    print("=" * 40)
    print("Press Ctrl+C to stop\n")

    pomodoro_count = 0

    try:
        while True:
            pomodoro_count += 1
            print(f"\n[Pomodoro #{pomodoro_count}]")

            if not countdown(work_duration, "WORK"):
                break

            input("Press Enter to start break...")

            if pomodoro_count % pomodoros_before_long_break == 0:
                if not countdown(long_break, "LONG BREAK"):
                    break
            else:
                if not countdown(short_break, "SHORT BREAK"):
                    break

            input("Press Enter to start next pomodoro...")

    except KeyboardInterrupt:
        print("\n\nPomodoro session ended.")

    print(f"\nCompleted {pomodoro_count} pomodoro(s). Great work!")


if __name__ == "__main__":
    pomodoro()
