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
| **Go** | `go/pomodoro.go` | `cd go && go run pomodoro.go` |
| **Perl** | `perl/pomodoro.pl` | `cd perl && ./pomodoro.pl` |
| **AppleScript** | `applescript/pomodoro.applescript` | `cd applescript && osascript pomodoro.applescript` |
| **Awk** | `awk/pomodoro.awk` | `cd awk && ./pomodoro.awk` |
| **Tcl** | `tcl/pomodoro.tcl` | `cd tcl && ./pomodoro.tcl` |

### Graphical User Interface (GUI)

Native macOS implementations using Swift.

| Type | File | Description | Run Command |
|------|------|-------------|-------------|
| **Cocoa App** | `swift/pomodoro_GUI.swift` | A minimal windowed app with Start/Reset controls. | `cd swift && ./pomodoro_GUI.swift` |
| **Analog Clock** | `swift/clock.swift` | An analog clock visualization with animated hands and dot markers. | `cd swift && ./clock.swift` |

## Requirements

- **macOS**: The Cocoa apps (Swift) and AppleScript are designed for macOS.
- **Swift**: For `pomodoro.swift` (Linux/macOS) and the macOS GUI apps.
- **Python 3**: For `pomodoro.py`.
- **Ruby**: For `pomodoro.rb`.
- **Rust/Cargo**: For `pomodoro_rust`.
- **C Compiler**: Clang or GCC for `pomodoro.c`.
- **Lua**: For `pomodoro.lua`.
- **Go**: For `pomodoro.go`.
- **Perl**: For `pomodoro.pl`.
- **Awk**: For `pomodoro.awk`.
- **Tcl**: For `pomodoro.tcl`.
