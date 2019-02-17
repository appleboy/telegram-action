#!/bin/sh

set -eu

export TELEGRAM_MESSAGE="$*"

/bin/drone-telegram
