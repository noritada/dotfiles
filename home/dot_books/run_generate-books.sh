#!/bin/bash

set -euxo pipefail

build_mdbook() {
    local readonly name="$1"
    local readonly repo="$2"
    local readonly subdir="$3"

    mkdir -p "$name"
    (
        local readonly repo_url="https://${repo}.git"
        local readonly repo_path="${HOME}/ghq/${repo}"
        if [ ! -e "$repo_path" ]; then
           ghq get "$repo_url"
        fi

        cd "$repo_path"
        local readonly rev=$(git describe --tags --abbrev=0 || echo "HEAD")
        git archive --format=tar $rev
    ) | tar -C "$name" -xf -
    (cd "$name/$subdir" && mdbook build)
}

build_mdbook mdBook github.com/rust-lang/mdBook guide
build_mdbook rust-cookbook github.com/rust-lang-nursery/rust-cookbook .
build_mdbook patterns github.com/rust-unofficial/patterns .
build_mdbook rustwasm-book github.com/rustwasm/book .
build_mdbook wasm-bindgen github.com/rustwasm/wasm-bindgen guide
