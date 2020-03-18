#!/bin/sh

set -eu

IP=$(curl --connect-timeout 10 https://link-ip.nextdns.io/d6e16a/6b2547b0ccf8c7e1 2>/dev/null)
if [ "$IP" ] ; then
	echo "$IP"
else
	echo "!"
fi

