# Gemini Project: Polyglot Pomodoro

This file provides context for the Gemini AI assistant about the `polyglot-pomodoro` project.

## Project Overview

This project is a collection of simple Pomodoro timer implementations in various programming languages. It's designed to be a "Rosetta Stone" for comparing how different languages handle basic console I/O, timing, and logic. It also includes some native macOS GUI examples using Swift.

The directory contains multiple standalone files, each being a distinct implementation of the same core Pomodoro logic.

## Core Pomodoro Logic

All implementations adhere to the following timing rules:
- **Work Session**: 25 minutes
- **Short Break**: 5 minutes
- **Long Break**: 15 minutes
- **Long Break Interval**: A long break occurs after every 4th work session (pomodoro).

## Implementations & How to Run

### Command Line Interface (CLI)

| Language | File | Run Command |
|---|---|---|
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
| **Awk** | `awk/pomodoro.awk` | `cd awk && ./pomodoro.awk` |
| **AppleScript** | `applescript/pomodoro.applescript` | `cd applescript && osascript pomodoro.applescript` |

### Graphical User Interface (GUI) - macOS

| Type | File | Description | Run Command |
|---|---|---|---|
| **Cocoa App** | `swift/pomodoro_GUI.swift` | A minimal windowed app with Start/Reset controls. | `cd swift && ./pomodoro_GUI.swift` |
| **Analog Clock**| `swift/clock.swift` | An analog clock visualization. | `cd swift && ./clock.swift` |

## Development Conventions

- **Consistency**: When adding a new implementation, it should follow the same core logic and output format as the existing ones.
- **Simplicity**: The goal is to write clear, idiomatic code that is easy to understand for someone familiar with the language. Avoid unnecessary complexity or external dependencies where possible.
- **Documentation**: If an implementation has specific build or run requirements, they should be documented in the main `README.md`.
