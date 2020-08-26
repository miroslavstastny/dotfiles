# Fast key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 16
defaults write NSGlobalDomain KeyRepeat -int 1

# Dock
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock show-recents -bool FALSE

killall Dock