# Configs using command line

```
# screenshot save location
mkdir ~/Desktop/screenshots
defaults write com.apple.screencapture location ~/Desktop/screenshots

# disable auto swoosh (automatic space switching)
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

# install Homebrew (see https://brew.sh/index_ja )
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install rustup (see https://rustup.rs/ )
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt
```

# Apps

## from App Store
* LibreOffice Vanilla

## from Internet
* Atom
* Docker
* Firefox
* Google Chrome
* Google Earth Pro
* Google Japanese Input
* Skype
* Gapminder Offline
* VSCode

## others
* Command Line Tools for Xcode
  * Terminalにてgccコマンドを叩いてトリガー

## from Homebrew
  * wget
  * python3
    * pip3, pip3.6も一緒にインストールされる
  * jq
  * nkf
  * neovim
  * git
  * cmake
  * cairo
  * neomutt
  * w3m
  * protobuf
  * wabt
  * ansible
  * ffmpeg
  * poppler
  * pandoc
  * aspell
  * git-gui
  * gh
  * nodebrew

## from Homebrew Cask
* adobe-acrobat-reader
* calibre
* emacs
* microsoft-remote-desktop-beta
* postman
* slack
* vlc
* drawio

## from npm

* copy-webpack-plugin
* npm
* webpack
* webpack-dev-server

## from pip3
* awscli
* requests
* Sphinx
* sphinx-intl
* sphinx_rtd_theme
* nbsphinx
* ipython
* black
* pytest
* pytest-html

## from cargo
* wasm-pack
* mdbook
* wasm-bindgen-cli
* monolith

# Dock
* 上記追加インストールアプリ
* /Applications/Utilities/Activity Monitor.app （アクティビティモニタ）
* /Applications/Utilities/Terminal.app （ターミナル）
* /System/Library/CoreServices/Applications/About This Mac.app （このMacについて）
* /System/Library/CoreServices/Applications/Wireless Diagnostics.app （ワイヤレス診断）


# System Preferences
## iCloud
* アカウント設定

## 共有
* コンピュータ名を社内ガイドラインどおりに修正
* 「リモートログイン」サービスをオンに

## ネットワーク
* VPNの設定を追加

## プリンタとスキャナ
* プリンタを追加


# Configs
* .ssh/、.zshrc、.zsh_historyを持ってくる


# Preferences
## Finder
* 「サイドバーに表示する項目」にホームディレクトリを追加

## Terminal
* プロファイルに「ZenburnCustomized」を追加
  * ZenburnCustomizedの設定ファイルを持ってきてインポート
  * 「コマンドを実行」内の「シェル内で実行」のチェックを外す
  * 「シェルの終了時」を「シェルが正常に終了した場合は閉じる」


# Add-ons
## Atom
* atomic-emacs
* goto-definition
* minimap
* project-manager
* tablr
* markdown-pdf


# Misc
* ユーザ辞書（ことえり）
* ユーザ辞書（Google日本語入力）

* pip3.6 install poyonga --user
