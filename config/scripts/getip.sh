#!/bin/bash
IP=$(curl --connect-timeout 3 ipecho.net/plain 2>/dev/null)
if [ $IP ]
then echo $IP
else echo "!"
fi
