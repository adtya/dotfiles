#!/bin/sh

set -eu

IP=$(curl --connect-timeout 10 https://ifconfig.me 2>/dev/null)
if [ "$IP" ] ; then
	echo "$IP"
else
	echo "!"
fi

