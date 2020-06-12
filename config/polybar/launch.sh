#!/bin/sh

polybar-msg cmd quit

polybar topbar >> /tmp/polybar.log 2>&1 &

