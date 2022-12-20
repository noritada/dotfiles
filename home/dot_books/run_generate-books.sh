#!/bin/bash

set -euxo pipefail

build_mdbook() {
    local readonly name="$1"
    local readonly repo_path="$2"
    local readonly subdir="$3"

    mkdir -p "$name"
    (
        cd "$repo_path"
        local readonly rev=$(git describe --tags --abbrev=0 || echo "HEAD")
        git archive --format=tar $rev
    ) | tar -C "$name" -xf -
    (cd "$name/$subdir" && mdbook build)
}

build_mdbook mdBook ~/ghq/github.com/rust-lang/mdBook guide
build_mdbook rust-cookbook ~/ghq/github.com/rust-lang-nursery/rust-cookbook .
build_mdbook patterns ~/ghq/github.com/rust-unofficial/patterns .
build_mdbook rustwasm-book ~/ghq/github.com/rustwasm/book .
build_mdbook wasm-bindgen ~/ghq/github.com/rustwasm/wasm-bindgen guide
