# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a polyglot Pomodoro timer project - a collection of standalone implementations of the same Pomodoro timer logic in different programming languages. The project serves as a "Rosetta Stone" for comparing how different languages handle basic console I/O, timing, and control flow.

## Core Logic (All Implementations)

Every implementation must adhere to these timing constants:
- Work Session: 25 minutes
- Short Break: 5 minutes
- Long Break: 15 minutes
- Long Break Interval: Every 4th pomodoro

## Architecture

**Structure**: Each language implementation is completely standalone in its own directory. There are no shared libraries or dependencies between implementations.

**Pattern**: All implementations follow the same logical flow:
1. Display welcome banner with timing configuration
2. Loop: work session → prompt → break (short or long based on count) → prompt
3. Handle Ctrl+C gracefully with completion summary
4. Display countdown timer with in-place updates (MM:SS format)
5. Emit terminal bell (\a) when sessions complete

## Running Implementations

### CLI Implementations
```bash
# Python
cd python && python3 pomodoro.py

# Ruby
cd ruby && ruby pomodoro.rb

# Shell
cd shell && ./pomodoro.sh

# C (using Makefile)
cd c && make && ./pomodoro

# C (manual compilation)
cd c && gcc -Wall -O2 -o pomodoro pomodoro.c && ./pomodoro

# Rust
cd rust && cargo run

# Swift
cd swift && swift pomodoro.swift

# Lua
cd lua && ./pomodoro.lua

# JavaScript/Node
cd javascript && ./pomodoro.js

# Go
cd go && go run pomodoro.go

# Perl
cd perl && ./pomodoro.pl

# AppleScript (macOS only)
cd applescript && osascript pomodoro.applescript

# Awk
cd awk && ./pomodoro.awk

# Tcl
cd tcl && ./pomodoro.tcl
```

### GUI Implementations (macOS only)
```bash
# Swift Cocoa App
cd swift && ./pomodoro_GUI.swift

# Analog Clock
cd swift && ./clock.swift
```

## Development Guidelines

**Adding a New Language**: When implementing in a new language:
1. Create a new directory named after the language
2. Follow the exact same timing constants and flow
3. Use idiomatic patterns for that language (avoid unnecessary dependencies)
4. Ensure countdown displays update in-place on the same line
5. Handle keyboard interrupts gracefully
6. Update README.md with the new implementation

**Code Style**: Keep implementations simple and readable. The goal is clarity and comparison, not cleverness or advanced features.

**Consistency**: Match the output format of existing implementations - users should have similar experience across languages.
