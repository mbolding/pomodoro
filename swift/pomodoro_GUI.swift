#!/usr/bin/swift
import Cocoa
import Foundation

// --- The Logic Controller ---
// This class handles the timer logic and updates the UI elements.
class PomodoroController: NSObject {
    
    // Configuration used for testing. Change to 25 * 60 and 5 * 60 for real use.
    // Using shorter times here so you can see it switch modes quickly.
    let workSecondsRequest = 25 * 60 // 25 minutes
    let breakSecondsRequest = 5 * 60 // 5 minutes
    
    // State
    var currentSecondsLeft: Int
    var isWorkMode = true
    var timer: Timer?
    
    // UI Element References (will be linked later)
    weak var timeLabel: NSTextField?
    weak var statusLabel: NSTextField?
    weak var startButton: NSButton?
    
    override init() {
        self.currentSecondsLeft = workSecondsRequest
        super.init()
    }
    
    // Helper to format seconds into MM:SS string
    func formatTimeString(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateUI() {
        statusLabel?.stringValue = isWorkMode ? "🧠 Focus Time" : "☕️ Take a Break"
        timeLabel?.stringValue = formatTimeString(currentSecondsLeft)
        // Change color based on mode
        timeLabel?.textColor = isWorkMode ? NSColor.labelColor : NSColor.systemGreen
    }
    
    // The function called every second by the timer
    @objc func tickEvent() {
        if currentSecondsLeft > 0 {
            currentSecondsLeft -= 1
            updateUI()
        } else {
            // Time is up!
            timer?.invalidate()
            timer = nil
            NSSound.beep() // Simple system sound alert
            
            // Switch modes
            isWorkMode.toggle()
            currentSecondsLeft = isWorkMode ? workSecondsRequest : breakSecondsRequest
            
            startButton?.title = isWorkMode ? "Start Focus" : "Start Break"
            updateUI()
            
            // Optional: Bounce dock icon to grab attention
            NSApplication.shared.requestUserAttention(.criticalRequest)
        }
    }
    
    // --- Button Actions ---
    
    @objc func toggleTimerPressed(_ sender: NSButton) {
        if timer == nil {
            // Start timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tickEvent), userInfo: nil, repeats: true)
            sender.title = "Pause"
        } else {
            // Pause timer
            timer?.invalidate()
            timer = nil
            sender.title = "Resume"
        }
    }
    
    @objc func resetPressed(_ sender: NSButton) {
        timer?.invalidate()
        timer = nil
        isWorkMode = true
        currentSecondsLeft = workSecondsRequest
        startButton?.title = "Start Focus"
        updateUI()
    }
}


// --- The Application Delegate ---
// This handles app lifecycle events. Crucial for making the script quit when the window closes.
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    let window: NSWindow
    let controller: PomodoroController
    
    init(window: NSWindow, controller: PomodoroController) {
        self.window = window
        self.controller = controller
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        window.delegate = self
        window.makeKeyAndOrderFront(nil)
        window.level = .floating // Keep window on top (optional)
        controller.updateUI()
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func windowWillClose(_ notification: Notification) {
        // Terminate the script when the user closes the window button
        NSApplication.shared.terminate(nil)
    }
}


// --- Main Script Execution Starts Here ---

// 1. Create the application instance
let app = NSApplication.shared
app.setActivationPolicy(.regular) // Shows up in Dock and App Switcher

// 2. Create the main window
let windowRect = NSMakeRect(0, 0, 300, 220)
let window = NSWindow(contentRect: windowRect,
                      styleMask: [.titled, .closable, .miniaturizable],
                      backing: .buffered,
                      defer: false)
window.title = "Swift Pomodoro"
window.center()

// 3. Initialize the logic controller
let pomoController = PomodoroController()

// 4. Create UI Elements programmatically (using StackViews for easy layout)

// Main Vertical Stack
let mainStack = NSStackView()
mainStack.orientation = .vertical
mainStack.alignment = .centerX
mainStack.spacing = 15
mainStack.edgeInsets = NSEdgeInsets(top: 25, left: 20, bottom: 25, right: 20)

// Status Label (e.g., Focus Time)
let statusLbl = NSTextField(labelWithString: "Status")
statusLbl.font = NSFont.systemFont(ofSize: 18, weight: .medium)
pomoController.statusLabel = statusLbl
mainStack.addArrangedSubview(statusLbl)

// Timer Label (e.g., 25:00)
// Using monospaced digit font so numbers don't wiggle as they change
let timerLbl = NSTextField(labelWithString: "00:00")
timerLbl.font = NSFont.monospacedDigitSystemFont(ofSize: 60, weight: .bold)
pomoController.timeLabel = timerLbl
mainStack.addArrangedSubview(timerLbl)

// Horizontal stack for buttons
let buttonStack = NSStackView()
buttonStack.orientation = .horizontal
buttonStack.spacing = 12

let startBtn = NSButton(title: "Start Focus", target: pomoController, action: #selector(PomodoroController.toggleTimerPressed(_:)))
startBtn.bezelStyle = .rounded
startBtn.controlSize = .large
startBtn.keyEquivalent = "\r" // Enter key triggers start
pomoController.startButton = startBtn
buttonStack.addArrangedSubview(startBtn)

let resetBtn = NSButton(title: "Reset", target: pomoController, action: #selector(PomodoroController.resetPressed(_:)))
resetBtn.bezelStyle = .rounded
resetBtn.controlSize = .large
buttonStack.addArrangedSubview(resetBtn)

mainStack.addArrangedSubview(buttonStack)

// Set the window's content to our stack view layout
window.contentView = mainStack


// 5. Set up the delegate and run the app loop
let delegate = AppDelegate(window: window, controller: pomoController)
app.delegate = delegate

// Start the main event loop. This blocks the script until terminated.
app.run()