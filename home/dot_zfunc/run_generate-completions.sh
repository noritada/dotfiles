#!/bin/bash

set -euxo pipefail

rustup completions zsh > _rustup
rustup completions zsh cargo > _cargo
mdbook completions zsh > _mdbook
