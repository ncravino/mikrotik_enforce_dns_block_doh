#!/usr/bin/env bash

grep --version >> /dev/null || { echo "Please install grep" ; exit 1; }
sed --version >> /dev/null || { echo "Please install sed" ; exit 1; }

echo "Processing..."

echo "/ip firewall address-list" > mikrotik_doh_list_commands.txt
cat iplist.txt | grep -v '#' | grep '\S' | sed 's/\s\(\S\)/\1/' | xargs -I% echo 'add address=% list="DoH Servers"' >> mikrotik_doh_list_commands.txt

echo "All done"