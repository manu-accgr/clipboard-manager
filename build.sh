#!/bin/bash

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_NAME="ClipboardManager"
APP_BUNDLE="$APP_NAME.app"
CONTENTS="$APP_BUNDLE/Contents"
MACOS="$CONTENTS/MacOS"

# Build the clipboard manager executable
swiftc -o clipboard-manager main.swift -framework Cocoa

# Create app bundle structure
rm -rf "$APP_BUNDLE"
mkdir -p "$MACOS"

# Copy executable to app bundle
cp clipboard-manager "$MACOS/"

# Copy Info.plist to app bundle
cp Info.plist "$CONTENTS/"

echo "Build complete. App bundle created: $APP_BUNDLE"
echo "Run with: open $APP_BUNDLE"