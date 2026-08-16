#!/bin/sh

set -eu

export GITHUB="true"

# The runner exports every declared input as an env var even when unset,
# and drone-telegram rejects an empty string for this integer flag.
[ -z "${INPUT_MESSAGE_THREAD_ID:-}" ] && unset INPUT_MESSAGE_THREAD_ID

/bin/drone-telegram
