#!/bin/bash
# Installs a launchd agent that runs auto-push.sh whenever notes/ (or the repo folder) changes, every 5 minutes, and at login.
# Run once on each laptop after cloning the repo to ~/llm-learning.
# Also removes the old lms-learning job and Desktop shortcut from before the rename.
# The real folder lives outside Desktop because macOS blocks background jobs from reading Desktop.
set -e
REPO="$HOME/llm-learning"
LABEL="com.rohit.llm-learning.autopush"
OLD_LABEL="com.rohit.lms-learning.autopush"

[ -d "$REPO/.git" ] || { echo "No repo at $REPO. Clone or move it there first."; exit 1; }

# Remove the pre-rename job and shortcut, if present.
launchctl bootout "gui/$(id -u)/$OLD_LABEL" 2>/dev/null || true
rm -f "$HOME/Library/LaunchAgents/$OLD_LABEL.plist"
[ -L "$HOME/Desktop/lms-learning" ] && rm "$HOME/Desktop/lms-learning"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

chmod +x "$REPO/scripts/auto-push.sh"
[ -e "$HOME/Desktop/llm-learning" ] || ln -s "$REPO" "$HOME/Desktop/llm-learning"
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
  <array><string>$REPO/notes</string><string>$REPO</string></array>
  <key>StartInterval</key><integer>300</integer>
  <key>RunAtLoad</key><true/>
  <key>EnvironmentVariables</key>
  <dict><key>PATH</key><string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string></dict>
</dict>
</plist>
EOF

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
# bootout returns before the old job is fully gone; loading too early fails with error 5.
for _ in $(seq 1 20); do
  launchctl print "gui/$(id -u)/$LABEL" >/dev/null 2>&1 || break
  sleep 0.5
done
launchctl bootstrap "gui/$(id -u)" "$PLIST"
echo "Installed. Log: $HOME/Library/Logs/llm-learning-autopush.log"
