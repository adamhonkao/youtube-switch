#!/bin/sh
# Builds "YouTube Switch.app" and the download zip in site/.
set -e
cd "$(dirname "$0")"
rm -rf build && mkdir build && cd build
python3 ../src/icon.py
iconutil -c icns icon.iconset -o applet.icns
cp icon-preview.png ../site/icon.png && sips -Z 256 ../site/icon.png >/dev/null
osacompile -o "YouTube Switch.app" ../src/app.applescript
cp ../src/toggle.sh applet.icns "YouTube Switch.app/Contents/Resources/"
# osacompile's default icon (Assets.car) overrides ours; drop it
rm -f "YouTube Switch.app/Contents/Resources/Assets.car"
plutil -remove CFBundleIconName "YouTube Switch.app/Contents/Info.plist"
codesign --force --deep -s - "YouTube Switch.app"
ditto -c -k --keepParent "YouTube Switch.app" ../site/YouTube-Switch.zip
echo "Built site/YouTube-Switch.zip"
