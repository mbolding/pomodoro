import AppKit

let alert = NSAlert()
alert.messageText = "Lab Update"
alert.informativeText = "The neural data has been synced to the server."
alert.addButton(withTitle: "Copy Path")
alert.addButton(withTitle: "Dismiss")
alert.runModal()