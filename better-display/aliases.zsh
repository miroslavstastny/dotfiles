better-display-studio() {
  /Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set -nameLike="center" -ddcAlt=144 -vcp=inputSelectAlt # HDMI1 - Studio
  /Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set -nameLike="right" -ddcAlt=208 -vcp=inputSelectAlt # DP1 - Studio
  /Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set -nameLike="LG" -connected=off
}

better-display-mbp() {
  /Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay perform -connectAllDisplays
  /Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set -nameLike="right" -ddcAlt=144 -vcp=inputSelectAlt # HDMI1 - MBP
  /Applications/BetterDisplay.app/Contents/MacOS/BetterDisplay set -nameLike="center" -ddcAlt=209 -vcp=inputSelectAlt # USB-C - MBP
}