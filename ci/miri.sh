#!/bin/bash

set -ex

export RUSTFLAGS="-D warnings"

if [[ "$OSTYPE" != "linux"* ]]; then
    exit 0
fi

MIRI_NIGHTLY=nightly-$(curl -s https://rust-lang.github.io/rustup-components-history/x86_64-unknown-linux-gnu/miri)
rustup set profile minimal
rustup update "$MIRI_NIGHTLY"
rustup default "$MIRI_NIGHTLY"
rustup component add miri

cargo miri test "${@}"
