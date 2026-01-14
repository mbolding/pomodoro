#!/usr/bin/env python3
"""A Pomodoro timer with Tkinter GUI."""

import tkinter as tk
from tkinter import font

WORK_DURATION = 25 * 60
SHORT_BREAK = 5 * 60
LONG_BREAK = 15 * 60
POMODOROS_BEFORE_LONG_BREAK = 4


class PomodoroTimer:
    def __init__(self, root):
        self.root = root
        self.root.title("Pomodoro Timer")
        self.root.geometry("400x300")
        self.root.resizable(False, False)

        self.time_remaining = WORK_DURATION
        self.is_running = False
        self.is_work_session = True
        self.pomodoro_count = 0
        self.timer_id = None

        self.setup_ui()

    def setup_ui(self):
        # Status label
        self.status_label = tk.Label(
            self.root,
            text="Ready to start",
            font=font.Font(size=14),
            pady=10
        )
        self.status_label.pack()

        # Timer display
        self.timer_label = tk.Label(
            self.root,
            text=self.format_time(),
            font=font.Font(size=48, weight="bold"),
            pady=20
        )
        self.timer_label.pack()

        # Pomodoro counter
        self.counter_label = tk.Label(
            self.root,
            text=f"Pomodoros: {self.pomodoro_count}",
            font=font.Font(size=12),
            pady=10
        )
        self.counter_label.pack()

        # Buttons frame
        button_frame = tk.Frame(self.root)
        button_frame.pack(pady=20)

        self.start_pause_btn = tk.Button(
            button_frame,
            text="Start",
            command=self.toggle_start_pause,
            width=10,
            font=font.Font(size=12)
        )
        self.start_pause_btn.pack(side=tk.LEFT, padx=5)

        self.reset_btn = tk.Button(
            button_frame,
            text="Reset",
            command=self.reset,
            width=10,
            font=font.Font(size=12)
        )
        self.reset_btn.pack(side=tk.LEFT, padx=5)

    def format_time(self):
        """Format time as MM:SS."""
        mins = self.time_remaining // 60
        secs = self.time_remaining % 60
        return f"{mins:02d}:{secs:02d}"

    def toggle_start_pause(self):
        """Toggle between start/pause states."""
        if not self.is_running:
            self.start()
        else:
            self.pause()

    def start(self):
        """Start the timer."""
        if not self.is_running:
            self.is_running = True
            self.start_pause_btn.config(text="Pause")

            # Update status if starting a new session
            if self.time_remaining in [WORK_DURATION, SHORT_BREAK, LONG_BREAK]:
                if self.is_work_session:
                    self.pomodoro_count += 1
                    self.counter_label.config(text=f"Pomodoros: {self.pomodoro_count}")
                    self.status_label.config(text=f"WORK SESSION #{self.pomodoro_count}")
                else:
                    if (self.pomodoro_count % POMODOROS_BEFORE_LONG_BREAK) == 0:
                        self.status_label.config(text="LONG BREAK")
                    else:
                        self.status_label.config(text="SHORT BREAK")

            self.countdown()

    def pause(self):
        """Pause the timer."""
        if self.is_running:
            self.is_running = False
            self.start_pause_btn.config(text="Resume")
            if self.timer_id:
                self.root.after_cancel(self.timer_id)

    def reset(self):
        """Reset the timer to initial state."""
        self.is_running = False
        self.is_work_session = True
        self.time_remaining = WORK_DURATION
        self.pomodoro_count = 0

        if self.timer_id:
            self.root.after_cancel(self.timer_id)

        self.timer_label.config(text=self.format_time())
        self.status_label.config(text="Ready to start")
        self.counter_label.config(text=f"Pomodoros: {self.pomodoro_count}")
        self.start_pause_btn.config(text="Start")

    def countdown(self):
        """Count down one second."""
        if self.is_running:
            if self.time_remaining > 0:
                self.time_remaining -= 1
                self.timer_label.config(text=self.format_time())
                self.timer_id = self.root.after(1000, self.countdown)
            else:
                self.session_complete()

    def session_complete(self):
        """Handle session completion."""
        self.is_running = False

        # Play system bell
        self.root.bell()

        if self.is_work_session:
            # Switch to break
            self.is_work_session = False
            if (self.pomodoro_count % POMODOROS_BEFORE_LONG_BREAK) == 0:
                self.time_remaining = LONG_BREAK
            else:
                self.time_remaining = SHORT_BREAK
            self.status_label.config(text="Work session complete! Take a break.")
        else:
            # Switch to work
            self.is_work_session = True
            self.time_remaining = WORK_DURATION
            self.status_label.config(text="Break complete! Ready for work.")

        self.timer_label.config(text=self.format_time())
        self.start_pause_btn.config(text="Start")


def main():
    root = tk.Tk()
    app = PomodoroTimer(root)
    root.mainloop()


if __name__ == "__main__":
    main()
