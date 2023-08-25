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
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
    rustup component add rustfmt
    rustup target add wasm32-unknown-unknown
    rustup target add x86_64-pc-windows-gnu
fi

# install Go (see https://go.dev/doc/install )
if !(type "go" > /dev/null 2>&1); then
    curl -sSL -O https://go.dev/dl/go1.21.0.darwin-arm64.pkg
    sudo installer -pkg go1.21.0.darwin-arm64.pkg -target /
fi

# install Poetry (see https://python-poetry.org/docs/ )
curl -sSL https://install.python-poetry.org | python3 -

# install Rye (see https://rye-up.com/guide/installation/ )
if !(type "rye" > /dev/null 2>&1); then
    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
    source "$HOME/.rye/env"
fi

# install Homebrew packages
brew install cmake jq nkf pandoc wget
brew install --cask brave-browser deepl drawio emacs slack visual-studio-code vlc vscodium wireshark zoom
