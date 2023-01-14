#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "No argument supplied"
    echo "usage: ./generate_for_router.sh router_internal_ip"
    exit 1 
fi


echo "Redirect all port 53 DNS traffic to router"
echo '/ip firewall nat' > mikrotik_all_commands.txt
echo 'add chain=dstnat action=dst-nat to-addresses=192.168.88.1 to-ports=53 protocol=udp dst-port=53 log=no log-prefix="" ' >> mikrotik_all_commands.txt
echo 'add chain=dstnat action=dst-nat to-addresses=192.168.88.1 to-ports=53 protocol=tcp dst-port=53 log=no log-prefix="" ' >> mikrotik_all_commands.txt

echo "Add firewall rule to block DoH via address list"
echo '/ip firewall filter'>> mikrotik_all_commands.txt
echo 'add action=drop chain=forward comment="drop DoH" dst-address-list="DoH Servers"' >> mikrotik_all_commands.txt

echo "Add hosts to address list"
cat mikrotik_doh_list_commands.txt >> mikrotik_all_commands.txt
echo "All Done"
echo ""
echo "Remember to config your DNS / DoH servers via WebFig or Terminal"
echo ""
