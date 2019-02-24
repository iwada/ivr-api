#!/bin/sh

#$RELEASE_ROOT_DIR/bin/ivr command Elixir.Ivr.ReleaseTasks seed

release_ctl eval --mfa "Ivr.ReleaseTasks.seed/1" --argv -- "$@