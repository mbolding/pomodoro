# Python Tkinter Pomodoro GUI

A cross-platform GUI Pomodoro timer built with Python and Tkinter.

## Features

- Start/Pause/Resume functionality
- Automatic switching between work sessions and breaks
- Visual timer display
- Pomodoro counter
- System bell notification on completion

## Requirements

- Python 3 with Tkinter support

### Checking if Tkinter is installed

```bash
python3 -c "import tkinter"
```

If this command runs without errors, Tkinter is installed.

### Installing Tkinter

**Linux (Debian/Ubuntu):**
```bash
sudo apt-get install python3-tk
```

**Linux (Fedora):**
```bash
sudo dnf install python3-tkinter
```

**Linux (Arch):**
```bash
sudo pacman -S tk
```

**macOS:**
Tkinter is included with the official Python installer from python.org. If using Homebrew:
```bash
brew install python-tk
```

**Windows:**
Tkinter is included with the official Python installer from python.org.

## Running

```bash
python3 pomodoro_gui.py
```

Or make it executable and run directly:
```bash
chmod +x pomodoro_gui.py
./pomodoro_gui.py
```

## How It Works

1. Click "Start" to begin a work session (25 minutes)
2. The timer counts down and displays MM:SS
3. When complete, it switches to a break (5 minutes for short breaks, 15 minutes for long breaks every 4th pomodoro)
4. A system bell sounds when sessions complete
5. Use "Pause" to pause the timer, "Resume" to continue
6. Use "Reset" to restart from the beginning
