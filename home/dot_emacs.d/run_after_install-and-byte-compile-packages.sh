#!/bin/bash

set -eux

/Applications/Emacs.app/Contents/MacOS/Emacs --batch -f batch-byte-compile init.el
