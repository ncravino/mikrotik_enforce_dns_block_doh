#!/usr/bin/env bash

echo "Redirect all port 53 DNS traffic to router"
echo '/ip firewall nat' > mikrotik_all_commands.txt

echo 'add action=redirect chain=dstnat dst-port=53 protocol=udp to-ports=53' >> mikrotik_all_commands.txt
echo 'add action=redirect chain=dstnat dst-port=53 protocol=tcp to-ports=53' >> mikrotik_all_commands.txt

echo "Add firewall rule to block DoH via address list"
echo '/ip firewall filter'>> mikrotik_all_commands.txt
echo 'add action=drop chain=forward comment="drop DoH" dst-address-list="DoH Servers"' >> mikrotik_all_commands.txt

echo "Add hosts to address list"
cat mikrotik_doh_list_commands.txt >> mikrotik_all_commands.txt
echo "All Done"
echo ""
echo "Remember to config your DNS / DoH servers via WebFig or Terminal"
echo ""
