#!/bin/bash
IP=$(curl --connect-timeout 10 https://ifconfig.me/ip 2>/dev/null)
if [ $IP ]
then echo $IP
else echo "!"
fi
