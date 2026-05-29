#!/bin/bash

# Remove from login items using AppleScript
osascript -e "tell application \"System Events\" to delete login item \"ClipboardManager\""

echo "Clipboard manager removed from login items."