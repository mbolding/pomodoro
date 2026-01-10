# Polyglot Pomodoro

A collection of simple Pomodoro timer implementations in various programming languages. This project serves as a "Rosetta Stone" for comparing how different languages handle basic console I/O, timing, and logic, as well as some GUI implementations.

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
| **Python** | `pomodoro.py` | `python3 pomodoro.py` |
| **Ruby** | `pomodoro.rb` | `ruby pomodoro.rb` |
| **Shell** | `pomodoro.sh` | `./pomodoro.sh` (or `bash pomodoro.sh`) |
| **C** | `pomodoro.c` | `clang -o pomodoro_c pomodoro.c && ./pomodoro_c` |
| **Rust** | `pomodoro_rust/` | `cd pomodoro_rust && cargo run` |
| **Swift** | `pomodoro.swift` | `./pomodoro.swift` (or `swift pomodoro.swift`) |
| **Lua** | `pomodoro.lua` | `./pomodoro.lua` (or `lua pomodoro.lua`) |

### Graphical User Interface (GUI)

Native macOS implementations using Swift.

| Type | File | Description | Run Command |
|------|------|-------------|-------------|
| **Cocoa App** | `pomodoro_GUI.swift` | A minimal windowed app with Start/Reset controls. | `./pomodoro_GUI.swift` |
| **Analog Clock** | `clock.swift` | An analog clock visualization with animated hands and dot markers. | `./clock.swift` |

## Requirements

- **macOS**: The Swift scripts and Cocoa apps are designed for macOS.
- **Python 3**: For `pomodoro.py`.
- **Ruby**: For `pomodoro.rb`.
- **Rust/Cargo**: For `pomodoro_rust`.
- **C Compiler**: Clang or GCC for `pomodoro.c`.
- **Lua**: For `pomodoro.lua`.
