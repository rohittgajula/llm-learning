#!/bin/bash
# Installs a launchd agent that runs auto-push.sh whenever notes/ changes.
# Run once on each laptop after cloning the repo to ~/lms-learning.
# The real folder lives outside Desktop because macOS blocks background jobs from reading Desktop.
set -e
REPO="$HOME/lms-learning"
LABEL="com.rohit.lms-learning.autopush"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

chmod +x "$REPO/scripts/auto-push.sh"
[ -e "$HOME/Desktop/lms-learning" ] || ln -s "$REPO" "$HOME/Desktop/lms-learning"
mkdir -p "$HOME/Library/LaunchAgents" "$HOME/Library/Logs"

cat >"$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/bash</string>
    <string>$REPO/scripts/auto-push.sh</string>
  </array>
  <key>WatchPaths</key>
  <array><string>$REPO/notes</string></array>
  <key>EnvironmentVariables</key>
  <dict><key>PATH</key><string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string></dict>
</dict>
</plist>
EOF

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"
echo "Installed. Log: $HOME/Library/Logs/lms-learning-autopush.log"
