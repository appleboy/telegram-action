#!/bin/sh

set -eu

export TELEGRAM_MESSAGE="$*"
export GITHUB="true"

/bin/drone-telegram
