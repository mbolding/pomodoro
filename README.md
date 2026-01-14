# Polyglot Pomodoro

A collection of simple Pomodoro timer implementations in various programming languages. This project is a personal "Rosetta Stone" for comparing how different languages handle basic console I/O, timing, and logic, as well as some GUI implementations.

## Features

All implementations share the same core logic:
- **Work Session**: 25 minutes
- **Short Break**: 5 minutes
- **Long Break**: 15 minutes
- **Long Break Interval**: Every 4th pomodoro

## Implementations

### Command Line Interface (CLI)

These scripts run a text-based countdown timer in your terminal.

| Language | File | Run Command |
|----------|------|-------------|
| **Python** | `python/pomodoro.py` | `cd python && python3 pomodoro.py` |
| **Ruby** | `ruby/pomodoro.rb` | `cd ruby && ruby pomodoro.rb` |
| **Shell** | `shell/pomodoro.sh` | `cd shell && ./pomodoro.sh` |
| **C** | `c/pomodoro.c` | `cd c && clang -o pomodoro_c pomodoro.c && ./pomodoro_c` |
| **Rust** | `rust/` | `cd rust && cargo run` |
| **Swift** | `swift/pomodoro.swift` | `cd swift && swift pomodoro.swift` |
| **Lua** | `lua/pomodoro.lua` | `cd lua && ./pomodoro.lua` |
| **JavaScript** | `javascript/pomodoro.js` | `cd javascript && ./pomodoro.js` (or `node javascript/pomodoro.js`) |
| **Java** | `java/Pomodoro.java` | `cd java && javac Pomodoro.java && java Pomodoro` |
| **Go** | `go/pomodoro.go` | `cd go && go run pomodoro.go` |
| **Perl** | `perl/pomodoro.pl` | `cd perl && ./pomodoro.pl` |
| **PHP** | `php/pomodoro.php` | `cd php && ./pomodoro.php` (or `php php/pomodoro.php`) |
| **AppleScript** | `applescript/pomodoro.applescript` | `cd applescript && osascript pomodoro.applescript` |
| **Awk** | `awk/pomodoro.awk` | `cd awk && ./pomodoro.awk` |
| **Tcl** | `tcl/pomodoro.tcl` | `cd tcl && ./pomodoro.tcl` |

### Graphical User Interface (GUI)

Cross-platform and native GUI implementations.

| Type | File | Description | Run Command |
|------|------|-------------|-------------|
| **Python/Tkinter** | `python-gui/pomodoro_gui.py` | Cross-platform GUI with Start/Pause/Reset controls. Uses Tkinter (included with Python). | `cd python-gui && python3 pomodoro_gui.py` |
| **Cocoa App** | `swift/pomodoro_GUI.swift` | A minimal windowed app with Start/Reset controls. No Xcode required. macOS only. | `cd swift && ./pomodoro_GUI.swift` |
| **Analog Clock** | `swift/clock.swift` | An analog clock visualization with animated hands and dot markers. No Xcode required. macOS only. | `cd swift && ./clock.swift` |

## Requirements

- **macOS**: The Cocoa apps (Swift) and AppleScript are designed for macOS.
- **Swift**: For `pomodoro.swift` (Linux/macOS) and the macOS GUI apps.
- **Python 3**: For `pomodoro.py` and the Tkinter GUI (`python-gui/`). Tkinter is included with most Python installations.
- **Ruby**: For `pomodoro.rb`.
- **Rust/Cargo**: For `pomodoro_rust`.
- **C Compiler**: Clang or GCC for `pomodoro.c`.
- **Lua**: For `pomodoro.lua`.
- **Go**: For `pomodoro.go`.
- **Java**: JDK 8 or higher for `Pomodoro.java`.
- **Perl**: For `pomodoro.pl`.
- **PHP**: PHP CLI with PCNTL extension for `pomodoro.php`.
- **Awk**: For `pomodoro.awk`.
- **Tcl**: For `pomodoro.tcl`.
