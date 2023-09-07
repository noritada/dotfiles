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

# remap keys on MacBook's built-in keyboard
# Caps Lock -> Control
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
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

# install nodebrew
curl -L git.io/nodebrew | perl - setup

# install Homebrew packages
brew install cmake eccodes git-gui hdf5 jq nkf pandoc podman protobuf tmux wget
brew install --cask brave-browser deepl drawio emacs firefox skype slack visual-studio-code vlc vscodium wireshark zed zoom

# install tools using toolchains of Rust and Go
cargo install --locked bat trunk
cargo install git-delta mdbook
go install github.com/knqyf263/utern@latest github.com/x-motemen/ghq@latest

# install other tools
bin_dir="${HOME}/.local/bin"
mkdir -p "${bin_dir}"

(
    # ensure fzf installed in ${HOME}/.local/bin
    version="0.42.0"
    fzf_base="${HOME}/.local"
    fzf_install="${fzf_base}/fzf-install"
    mkdir -p "${fzf_base}"
    curl -sS "https://raw.githubusercontent.com/junegunn/fzf/${version}/install" -o "${fzf_install}"
    chmod a+rx "${fzf_install}"
    "${fzf_install}" --no-key-bindings --no-completion --no-update-rc
    rm "${fzf_install}"
)

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
