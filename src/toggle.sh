#!/bin/sh
# YouTube Switch helper. Usage: toggle.sh block|allow <admin-username>
# Runs as root (the app asks for the admin password).
set -e
HOSTS="${HOSTS_FILE:-/etc/hosts}"
BEGIN="# BEGIN youtube-switch"
END="# END youtube-switch"
DOMAINS="youtube.com www.youtube.com m.youtube.com music.youtube.com youtu.be www.youtu.be youtube-nocookie.com www.youtube-nocookie.com youtubei.googleapis.com"

# One-time backup of the original hosts file
[ -f "$HOSTS.youtube-switch.bak" ] || cp "$HOSTS" "$HOSTS.youtube-switch.bak"

# Always remove our section first, so it is never added twice
tmp=$(mktemp)
sed "/^$BEGIN\$/,/^$END\$/d" "$HOSTS" > "$tmp"

if [ "$1" = "block" ]; then
  {
    echo "$BEGIN"
    for d in $DOMAINS; do
      echo "0.0.0.0 $d"
      echo ":: $d"
    done
    echo "$END"
  } >> "$tmp"
fi

cat "$tmp" > "$HOSTS"   # keeps the file's owner and permissions
rm -f "$tmp"

[ -n "$HOSTS_FILE" ] && exit 0   # test mode: stop here

# Flush the DNS cache so the change takes effect now
dscacheutil -flushcache || true
killall -HUP mDNSResponder || true

# On block, quit Chrome in every other account (not the admin's own)
if [ "$1" = "block" ]; then
  for pid in $(pgrep -x "Google Chrome" || true); do
    owner=$(ps -o user= -p "$pid" | tr -d ' ')
    [ "$owner" = "$2" ] || kill "$pid" || true
  done
fi
