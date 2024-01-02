#!/bin/bash

set -euxo pipefail

curl -sSL -O https://raw.githubusercontent.com/idleberg/sublime-gettext/master/Syntaxes/Gettext.sublime-syntax
bat cache --build
