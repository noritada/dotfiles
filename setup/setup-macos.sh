#!/bin/bash

# settings for screenshots
screenshots_dir="${HOME}/Desktop/screenshots"
if [ ! -e "${screenshots_dir}" ]; then
    defaults write com.apple.screencapture name ss
    mkdir "${screenshots_dir}"
    defaults write com.apple.screencapture location "${screenshots_dir}"
fi

# disable auto swoosh (automatic space switching)
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

# disable auto spelling correction
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# install Homebrew (see https://brew.sh/index_ja )
if !(type "brew" > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install rustup (see https://rustup.rs/ )
if !(type "rustup" > /dev/null 2>&1); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup component add rustfmt
    rustup target add wasm32-unknown-unknown
    rustup target add x86_64-pc-windows-gnu
fi

# install Poetry (see https://python-poetry.org/docs/ )
curl -sSL https://install.python-poetry.org | python3 -
