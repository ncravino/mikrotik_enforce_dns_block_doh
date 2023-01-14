# Mikrotik DNS and DoH (DNS over HTTP) Configs

## Configuring Mikrotik to use specified DNS or DNS over HTTP

On WebFig go to IP -> DNS.

Fill in `Servers` with your selected TCP/UDP servers and `Use DoH Server` with your selected DoH server.

Or use the terminal to achieve the same config.

## Redirecting all TCP/UDP DNS requests to your router

Assuming the router is on `192.168.88.1`.

You can do this via IP -> Firewall -> Nat on WebFig, or via terminal (SSH/web) with:
```
/ip firewall nat
add chain=dstnat action=dst-nat to-addresses=192.168.88.1 to-ports=53 protocol=udp dst-port=53 log=no log-prefix="" 
add chain=dstnat action=dst-nat to-addresses=192.168.88.1 to-ports=53 protocol=tcp dst-port=53 log=no log-prefix="" 
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

See the commands for adding a full list at [mirotik_doh_list_commands.txt](mikrotik_doh_list_commands.txt) based on data from [https://github.com/oneoffdallas/dohservers](https://github.com/oneoffdallas/dohservers) (see bellow for acknowlegements and license details).

## Scripts

All scripts sit under the `./scripts/` folder.

### `get_list.sh`

Gets current master of `iplist.txt` from [https://github.com/oneoffdallas/dohservers](https://github.com/oneoffdallas/dohservers).

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
- [https://github.com/oneoffdallas/dohservers](https://github.com/oneoffdallas/dohservers) for making available the data under their [MIT LICENSE](https://github.com/oneoffdallas/dohservers/blob/master/LICENSE).