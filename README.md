# Minimal Clipboard Manager for macOS

A simple, minimal clipboard manager that runs in the macOS menu bar.

## Features

- Menu bar icon (near the clock)
- Stores the last 10 clipboard items
- Click any item to copy it back to the clipboard
- Automatically monitors clipboard changes

## How to Build

```bash
./build.sh
```

Or manually:

```bash
swiftc -o clipboard-manager main.swift -framework Cocoa
```

## How to Run

```bash
./run.sh
```

Or manually:

```bash
open ClipboardManager.app
```

## Usage

1. Launch the app - you'll see a clipboard icon in the menu bar (top right, near the clock)
2. Copy text to your clipboard as usual (Cmd+C)
3. Click the clipboard icon to see your history
4. Click any item in the history to copy it back to the clipboard
5. Press Cmd+V to paste the selected item
6. Press "Quit" to exit the app

## Auto-Start at Login

To make the clipboard manager automatically start when you log in:

### Manual Method
1. Open **System Settings** → **General** → **Login Items**
2. Click the **+** button
3. Navigate to this directory and select the `ClipboardManager.app` bundle
4. Enable the toggle

### Automated Method
```bash
./add-to-login-items.sh
```

The app will start automatically in the background when you log in - no terminal window will appear. You'll only see the clipboard icon in your menu bar.

To remove from login items:
```bash
./remove-from-login-items.sh
```

## Requirements

- macOS
- Swift compiler (comes with Xcode or Xcode Command Line Tools)