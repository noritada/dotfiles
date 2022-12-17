#!/bin/bash

set -euxo pipefail

build_mdbook() {
    local readonly name="$1"
    local readonly repo_path="$2"
    local readonly subdir="$3"

    mkdir -p "$name"
    (
        cd "$repo_path"
        local readonly tag=$(git describe --tags --abbrev=0)
        git archive --format=tar $tag
    ) | tar -C "$name" -xf -
    (cd "$name/$subdir" && mdbook build)
}

build_mdbook mdBook ~/ghq/github.com/rust-lang/mdBook guide
