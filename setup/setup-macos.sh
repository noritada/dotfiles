#!/bin/bash

# settings for screenshots
defaults write com.apple.screencapture name ss
mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

# disable auto swoosh (automatic space switching)
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

# disable auto spelling correction
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# install Homebrew (see https://brew.sh/index_ja )
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install rustup (see https://rustup.rs/ )
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt
rustup target add wasm32-unknown-unknown
rustup target add x86_64-pc-windows-gnu

# install Poetry (see https://python-poetry.org/docs/ )
curl -sSL https://install.python-poetry.org | python3 -
