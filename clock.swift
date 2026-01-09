#!/usr/bin/swift
import Cocoa
import Foundation

// --- The Drawing View ---
class ClockView: NSView {
    
    var timer: Timer?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        // Refresh every 1 second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.needsDisplay = true 
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let context = NSGraphicsContext.current?.cgContext else { return }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        // Convert radius to Double for math consistency
        let radius = Double(min(bounds.width, bounds.height) * 0.45)
        
        // 1. Draw the Clock Face (Outer Circle)
        context.setLineWidth(4)
        context.setStrokeColor(NSColor.labelColor.cgColor)
        let faceRect = CGRect(x: Double(center.x) - radius, y: Double(center.y) - radius, width: radius * 2, height: radius * 2)
        context.strokeEllipse(in: faceRect)
        
        // 2. Draw Hour Markers (Ticks)
        context.setLineWidth(2)
        for i in 0..<12 {
            // Using Double explicitly solves the "ambiguity"
            let angle = Double(i) * (2.0 * Double.pi / 12.0)
            let p1 = CGPoint(
                x: Double(center.x) + (radius * 0.85) * cos(angle), 
                y: Double(center.y) + (radius * 0.85) * sin(angle)
            )
            let p2 = CGPoint(
                x: Double(center.x) + radius * cos(angle), 
                y: Double(center.y) + radius * sin(angle)
            )
            context.move(to: p1)
            context.addLine(to: p2)
            context.strokePath()
        }
        
        // 3. Get Current Time
        let date = Date()
        let calendar = Calendar.current
        let hour = Double(calendar.component(.hour, from: date))
        let minute = Double(calendar.component(.minute, from: date))
        let second = Double(calendar.component(.second, from: date))
        
        // 4. Calculate Angles (Clockwise logic)
        let secAngle = (Double.pi / 2.0) - (second / 60.0) * 2.0 * Double.pi
        let minAngle = (Double.pi / 2.0) - (minute / 60.0) * 2.0 * Double.pi
        let hourAngle = (Double.pi / 2.0) - ((hour.truncatingRemainder(dividingBy: 12) + (minute / 60.0)) / 12.0) * 2.0 * Double.pi
        
        // 5. Draw Hands
        drawHand(context: context, center: center, length: radius * 0.9, angle: secAngle, width: 1.5, color: NSColor.systemRed.cgColor)
        drawHand(context: context, center: center, length: radius * 0.85, angle: minAngle, width: 4, color: NSColor.labelColor.cgColor)
        drawHand(context: context, center: center, length: radius * 0.5, angle: hourAngle, width: 7, color: NSColor.labelColor.cgColor)
        
        // 6. Center Pin
        context.setFillColor(NSColor.labelColor.cgColor)
        context.fillEllipse(in: CGRect(x: center.x - 5, y: center.y - 5, width: 10, height: 10))
    }
    
    private func drawHand(context: CGContext, center: CGPoint, length: Double, angle: Double, width: CGFloat, color: CGColor) {
        context.setLineWidth(width)
        context.setStrokeColor(color)
        context.setLineCap(.round)
        
        // Casting Double math results back to CGFloat for the final Point
        let endPoint = CGPoint(
            x: Double(center.x) + length * cos(angle),
            y: Double(center.y) + length * sin(angle)
        )
        
        context.move(to: center)
        context.addLine(to: endPoint)
        context.strokePath()
    }
}

// --- The Application Setup ---

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let rect = NSMakeRect(0, 0, 400, 400)
        window = NSWindow(contentRect: rect,
                          styleMask: [.titled, .closable, .miniaturizable],
                          backing: .buffered,
                          defer: false)
        
        window.title = "Swift Analog Clock"
        window.center()
        window.delegate = self
        
        let clockView = ClockView(frame: rect)
        window.contentView = clockView
        
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func windowWillClose(_ notification: Notification) {
        NSApplication.shared.terminate(nil)
    }
}

let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = AppDelegate()
app.delegate = delegate
app.run()