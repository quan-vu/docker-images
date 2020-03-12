#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Chromium Browser"
apt-get update 
apt-get install -y chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg
apt-get clean -y
ln -s /usr/bin/chromium-browser /usr/bin/google-chrome
### fix to start chromium in a Docker container
echo "CHROMIUM_FLAGS='--no-sandbox --start-maximized --user-data-dir'" > $HOME/.chromium-browser.init
