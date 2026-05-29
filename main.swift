import Cocoa
import AppKit

class ClipboardManager: NSObject {
    private var statusItem: NSStatusItem?
    private var clipboardHistory: [String] = []
    private let maxHistoryItems = 10
    private var pasteboard = NSPasteboard.general
    private var changeCount: Int = 0

    override init() {
        super.init()
        setupStatusBar()
        startMonitoring()
    }

    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "doc.on.doc", accessibilityDescription: "Clipboard")
            button.action = #selector(statusBarButtonClicked)
            button.target = self
        }
    }

    private func startMonitoring() {
        changeCount = pasteboard.changeCount
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkForChanges()
        }
    }

    private func checkForChanges() {
        let currentChangeCount = pasteboard.changeCount
        if currentChangeCount != changeCount {
            changeCount = currentChangeCount
            if let content = pasteboard.string(forType: .string), !content.isEmpty {
                addToHistory(content)
            }
        }
    }

    private func addToHistory(_ content: String) {
        // Avoid duplicates
        if let lastItem = clipboardHistory.first, lastItem == content {
            return
        }
        
        clipboardHistory.insert(content, at: 0)
        if clipboardHistory.count > maxHistoryItems {
            clipboardHistory.removeLast()
        }
    }

    @objc private func statusBarButtonClicked() {
        guard let statusItem = statusItem else { return }
        
        let menu = NSMenu()
        
        if clipboardHistory.isEmpty {
            menu.addItem(NSMenuItem(title: "No clipboard history", action: nil, keyEquivalent: ""))
        } else {
            for (index, item) in clipboardHistory.enumerated() {
                let displayName = item.count > 50 ? String(item.prefix(50)) + "..." : item
                let menuItem = NSMenuItem(title: displayName, action: #selector(copyToClipboard(_:)), keyEquivalent: "")
                menuItem.tag = index
                menuItem.target = self
                menu.addItem(menuItem)
            }
        }
        
        menu.addItem(NSMenuItem.separator())
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        
        statusItem.menu = menu
        statusItem.button?.performClick(nil)
        statusItem.menu = nil
    }

    @objc private func copyToClipboard(_ sender: NSMenuItem) {
        let index = sender.tag
        if index < clipboardHistory.count {
            let content = clipboardHistory[index]
            pasteboard.clearContents()
            pasteboard.setString(content, forType: .string)
        }
    }

    @objc private func quit() {
        NSApplication.shared.terminate(nil)
    }
}

// App delegate
class AppDelegate: NSObject, NSApplicationDelegate {
    private var clipboardManager: ClipboardManager?

    func applicationDidFinishLaunching(_ notification: Notification) {
        clipboardManager = ClipboardManager()
    }
}

// Main
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()