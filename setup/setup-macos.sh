#!/bin/bash

# settings for screenshots
screenshots_dir="${HOME}/Desktop/screenshots"
defaults write com.apple.screencapture name ss
mkdir -p "${screenshots_dir}"
defaults write com.apple.screencapture location "${screenshots_dir}"

# disable auto swoosh (automatic space switching)
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

# disable auto spelling correction
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

remap-keys() {
  local keyboard_id="$1"

  defaults -currentHost delete -g com.apple.keyboard.modifiermapping.${keyboard_id}

  # Caps Lock -> Control
  defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add '
  <dict>
    <key>HIDKeyboardModifierMappingDst</key>
    <integer>30064771300</integer>
    <key>HIDKeyboardModifierMappingSrc</key>
    <integer>30064771129</integer>
  </dict>
  '

  # Control -> Caps Lock
  defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add '
  <dict>
    <key>HIDKeyboardModifierMappingDst</key>
    <integer>30064771129</integer>
    <key>HIDKeyboardModifierMappingSrc</key>
    <integer>30064771296</integer>
  </dict>
  '
  defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add '
  <dict>
    <key>HIDKeyboardModifierMappingDst</key>
    <integer>30064771129</integer>
    <key>HIDKeyboardModifierMappingSrc</key>
    <integer>30064771300</integer>
  </dict>
  '
}

# MacBook's built-in keyboard
remap-keys "$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
# KB800HM Kinesis Freestyle2 for Mac:
#   Product ID:	0x9410
#   Vendor ID: 	0x058f  (Alcor Micro, Corp.)
remap-keys "1423-37904-0"

# show status and path bars in Finder
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# use column view in Finder
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# disable two-finger swipe back/forward navigation
defaults write com.brave.Browser AppleEnableSwipeNavigateWithScrolls -bool FALSE
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool FALSE

# install Homebrew (see https://brew.sh/index_ja )
if !(type "brew" > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install rustup (see https://rustup.rs/ )
if !(type "rustup" > /dev/null 2>&1); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
fi
rustup component add rustfmt
rustup target add wasm32-unknown-unknown
rustup target add x86_64-pc-windows-gnu

# install Go (see https://go.dev/doc/install )
if !(type "go" > /dev/null 2>&1); then
    curl -sSL -O https://go.dev/dl/go1.21.0.darwin-arm64.pkg
    sudo installer -pkg go1.21.0.darwin-arm64.pkg -target /
fi

# install Poetry (see https://python-poetry.org/docs/ and
# https://github.com/python-poetry/install.python-poetry.org/issues/24 )
curl -sSL https://install.python-poetry.org | sed 's/symlinks=False/symlinks=True/' | python3 -

# install Rye (see https://rye-up.com/guide/installation/ )
if !(type "rye" > /dev/null 2>&1); then
    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" bash
    source "$HOME/.rye/env"
fi

# install nodebrew
curl -L git.io/nodebrew | perl - setup

# install Homebrew packages
brew install cmake coreutils eccodes exiftool ffmpeg gh git-gui hdf5 jq nkf pandoc podman procs protobuf tmux wget
brew install --cask brave-browser deepl drawio emacs firefox skype slack visual-studio-code vlc vscodium wireshark zed zoom

# install tools using toolchains of Rust and Go
cargo install --locked bat trunk
cargo install git-delta mdbook
go install github.com/knqyf263/utern@latest github.com/x-motemen/ghq@latest

# install other tools
bin_dir="${HOME}/.local/bin"
mkdir -p "${bin_dir}"

fzf_dir="${HOME}/.fzf"
if [ ! -d "${fzf_dir}" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "${fzf_dir}"
  "${fzf_dir}/install"
else
  (cd "${fzf_dir}" && git pull && ./install)
fi

curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o "${bin_dir}/yt-dlp"
chmod a+rx "${bin_dir}/yt-dlp"

# install git-filter-repo
(
    version="2.38.0"
    cd "${HOME}/.local/bin"
    curl -sS -O "https://raw.githubusercontent.com/newren/git-filter-repo/v${version}/git-filter-repo"
    chmod a+rx git-filter-repo
)

cargo install --git https://github.com/noritada/grib-rs.git grib-cli
cargo install --git https://github.com/noritada/rrr-rs.git rrr-cli

# install chezmoi (in ./.local/bin) and dotfiles
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply "noritada"
