#!/bin/sh

set -eu

pactl set-source-volume @DEFAULT_SOURCE@ -5%

