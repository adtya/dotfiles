#!/usr/bin/env bash

# Terminate all existing polybars
killall -q polybar

# Wait intill the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar mainbar &
