#!/usr/bin/env bash

curl --version || { echo "Please install curl" ; exit 1; }

curl https://raw.githubusercontent.com/dibdot/DoH-IP-blocklists/refs/heads/master/doh-ipv4.txt -o iplist.txt
echo "===================================================================="
echo "Remember to uncomment lines in iplist.txt for cloudflare if you want"
echo "===================================================================="