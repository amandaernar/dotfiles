#!/bin/bash

PROCESS_NAME="$1"
ICON="$2"
COLOR_ACTIVE="$3"
COLOR_INACTIVE="#8080c8"
FONT="2"

if pgrep -x "$PROCESS_NAME" >/dev/null; then
  echo "%{T$FONT}%{F$COLOR_ACTIVE} $ICON %{T-}"
else
  echo "%{T$FONT}%{F$COLOR_INACTIVE} $ICON %{T-}"
fi
