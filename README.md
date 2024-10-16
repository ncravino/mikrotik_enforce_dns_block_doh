# Mikrotik DNS and DoH (DNS over HTTP) Configs

## Configuring Mikrotik to use specified DNS or DNS over HTTP

On WebFig go to IP -> DNS.

Fill in `Servers` with your selected TCP/UDP servers and `Use DoH Server` with your selected DoH server.

Or use the terminal to achieve the same config.

## Redirecting all TCP/UDP DNS requests to your router
## The following NAT rules will redirect all UDP / TCP requests with port 53 to the router as destination ##
## The prior NAT rules will NOT work in a ROS VLAN environment ##

You can do this via IP -> Firewall -> Nat on WebFig, or via terminal (SSH/web) with:
```
/ip firewall nat
add action=redirect chain=dstnat dst-port=53 protocol=udp to-ports=53
add action=redirect chain=dstnat dst-port=53 protocol=tcp to-ports=53
```

## Blocking DoH requests via address list

Using terminal since it's faster, but you can create the same via WebFig.

### Create a firewall rule to drop these outgoing requests based on a list
```
/ip firewall filter
add action=drop chain=forward comment="drop DoH" dst-address-list="DoH Servers"
```

### Add DoH servers to the address list 
Use 
```
/ip firewall address-list add address=IP/HOST list="DoH Servers"
``` 

E.g.: 
```
/ip firewall address-list add address=dns.google list="DoH Servers"
``` 

See the commands for adding a full list at [mirotik_doh_list_commands.txt](mikrotik_doh_list_commands.txt) based on data from [https://github.com/dibdot/DoH-IP-blocklists](https://github.com/dibdot/DoH-IP-blocklists) (see bellow for acknowlegements and license details).

## Scripts

All scripts sit under the `./scripts/` folder.

### `get_list.sh`

Gets current master of `iplist.txt` from [https://github.com/dibdot/DoH-IP-blocklists](https://github.com/dibdot/DoH-IP-blocklists).

### `process_doh_list.sh`

Processes current iplist into mikrotik commands to add addresses to the list.

### `generate_for_router.sh`

Generates a `mikrotik_all_commands.txt` with the commands explained before.

```
usage: ./generate_for_router.sh router_internal_ip 
``` 

## Notes
- Tested on WSL2 running Debian and Debian 11.
- Commands tested for RouterOS v7.6 running on [Mikrotik hAP ac2](https://mikrotik.com/product/hap_ac2).
- Please review all commands and use at your own risk.
- See [BSD 3 CLAUSE LICENSE](LICENSE.md) for details.

## Finding Servers

You can find nice public servers at [Public DNS at European Alternatives](https://european-alternatives.eu/category/public-dns).

## Acknowledgements 

- [Mikrotik](https://mikrotik.com) for making awesome network hardware.
- [https://european-alternatives.eu](https://european-alternatives.eu) for collecting nice alternatives under one site.
- [https://github.com/dibdot/DoH-IP-blocklists](https://github.com/dibdot/DoH-IP-blocklists) for making the output of their program available.