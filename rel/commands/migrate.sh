#!/bin/sh

#$RELEASE_ROOT_DIR/bin/ivr command Elixir.Ivr.ReleaseTasks migrate

release_ctl eval --mfa "Ivr.ReleaseTasks.migrate/1" --argv -- "$@"