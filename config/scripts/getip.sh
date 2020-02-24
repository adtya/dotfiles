#!/bin/sh

set -eu

IP=$(curl --connect-timeout 10 ifconfig.me/ip 2>/dev/null)
if [ "$IP" ]
then echo "$IP"
else echo "!"
fi
