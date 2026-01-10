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
| **Python** | `python/pomodoro.py` | `cd python && python3 pomodoro.py` |
| **Ruby** | `ruby/pomodoro.rb` | `cd ruby && ruby pomodoro.rb` |
| **Shell** | `shell/pomodoro.sh` | `cd shell && ./pomodoro.sh` |
| **C** | `c/pomodoro.c` | `cd c && clang -o pomodoro_c pomodoro.c && ./pomodoro_c` |
| **Rust** | `rust/` | `cd rust && cargo run` |
| **Swift** | `swift/pomodoro.swift` | `cd swift && ./pomodoro.swift` |
| **Lua** | `lua/pomodoro.lua` | `cd lua && ./pomodoro.lua` |

### Graphical User Interface (GUI)

Native macOS implementations using Swift.

| Type | File | Description | Run Command |
|------|------|-------------|-------------|
| **Cocoa App** | `swift/pomodoro_GUI.swift` | A minimal windowed app with Start/Reset controls. | `cd swift && ./pomodoro_GUI.swift` |
| **Analog Clock** | `swift/clock.swift` | An analog clock visualization with animated hands and dot markers. | `cd swift && ./clock.swift` |

## Requirements

- **macOS**: The Swift scripts and Cocoa apps are designed for macOS.
- **Python 3**: For `pomodoro.py`.
- **Ruby**: For `pomodoro.rb`.
- **Rust/Cargo**: For `pomodoro_rust`.
- **C Compiler**: Clang or GCC for `pomodoro.c`.
- **Lua**: For `pomodoro.lua`.
