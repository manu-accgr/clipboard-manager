#!/bin/bash

# Get the absolute path of the ClipboardManager.app bundle
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_PATH="$SCRIPT_DIR/ClipboardManager.app"

# Add to login items using AppleScript (hidden=true to run in background)
osascript -e "tell application \"System Events\" to make login item at end with properties {name:\"ClipboardManager\", path:\"$APP_PATH\", hidden:true}"

echo "Clipboard manager added to login items. It will start automatically in the background on login."