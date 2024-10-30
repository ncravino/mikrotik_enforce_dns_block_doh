#!/usr/bin/env bash

grep --version >> /dev/null || { echo "Please install grep" ; exit 1; }
sed --version >> /dev/null || { echo "Please install sed" ; exit 1; }
gawk --version >> /dev/null || { echo "Please install awk" ; exit 1; }

echo "Processing..."

cat iplist.txt | grep -v '^\s*#' | gawk '{print $1}' > full_list.txt
cat mylist.txt | grep -v '^\s*#' | gawk '{print $1}' >> full_list.txt
gawk -i inplace 'FNR==1{delete a} !a[$0]++' full_list.txt

echo '/ip firewall address-list remove [find where list="DoH Servers"]' > mikrotik_doh_list_commands.txt
echo "/ip firewall address-list" >> mikrotik_doh_list_commands.txt
cat full_list.txt | sort -u | xargs -I% echo 'add address=% list="DoH Servers"' >> mikrotik_doh_list_commands.txt

echo "All done"
