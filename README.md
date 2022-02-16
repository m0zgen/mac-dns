# MAC DNS

Script for release and change IP DNS servers on WiFi interface in macOS.

Script using IP addresses:
* Google: 8.8.8.8, .8.8.2.2
* Cloudflare: 1.1.1.1, 1.0.0.1
* BLD DNS: 49.12.234.130, 135.125.204.230, 212.19.134.52 

Tested on: macOS Monterey

## Usage

Mixed DNS (Set Cloudflare and Google DNS):
```
./mac-dns-release.sh
```

Google:
```
./mac-dns-release.sh google
```

Cloudflare:
```
./mac-dns-release.sh cloudflare
```

BLD DNS:
```
./mac-dns-release.sh bld
```

or
```
./mac-dns-release.sh bld-kz
```

## Additional links

* Cloudflare: https://1.1.1.1/dns/
* Google: https://developers.google.com/speed/public-dns
* BLD DNS: https://lab.sys-adm.in/

