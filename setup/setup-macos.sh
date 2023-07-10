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
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install rustup (see https://rustup.rs/ )
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt
rustup target add wasm32-unknown-unknown
rustup target add x86_64-pc-windows-gnu

# install cn (see https://github.com/ceph/cn )
curl -L https://github.com/ceph/cn/releases/download/v2.3.1/cn-v2.3.1-darwin-amd64 -o ~/bin/cn && chmod +x ~/bin/cn

# install Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
