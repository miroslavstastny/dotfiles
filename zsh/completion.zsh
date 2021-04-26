# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# use menu on cd+tab
zstyle ':completion:*:*:*:*:*' menu select