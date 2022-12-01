#!/bin/bash

set -euxo pipefail

rustup completions zsh > _rustup
rustup completions zsh cargo > _cargo
mdbook completions zsh > _mdbook
rrr completions zsh > _rrr
chezmoi completion zsh --output="_chezmoi"
