#!/usr/bin/env bash
# Script for release and to set DNS IP from services:
# Google, Cloudflare, BLD
# https://github.com/nbcarey/flush-dns-osx/blob/master/flush-dns.sh

set -o errexit
set -o pipefail

# Functions
#------------------------------------------------------------------

fail() {
    echo ERROR: $*
    return 1
}

is_darwin() {
    local -r system_name=`uname -s`

    if [ "$system_name" == 'Darwin' ];
    then return 0;
    else return 1;
    fi;

}

is_osx() {
    local -r os_name=`sw_vers -productName`

    if [ "$os_name" == 'macOS' ];
    then return 0;
    else return 1;
    fi;

}

main() {

    # echo $1 $2

	if ! is_darwin; then
        fail "System is not OS X";
        exit 1
    fi;

    if ! is_osx; then
        fail "System is not OS X";
        exit 1
    fi;

    local -r osx_version=`sw_vers -productVersion`;

    echo "Setup DNS.."
	# Setup DNS
	# Set Custom DNS

    if [[ -z "$1" ]]; then
        echo "Set Cloudflare and Google DNS"
        networksetup -setdnsservers Wi-Fi 1.1.1.1 8.8.2.2
    elif [[ $1 = "google" ]]; then
        echo "Set Google DNS"
        networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
    elif [[ $1 = "cloudflare" ]]; then
        echo "Set Cloudflare DNS"
        networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1
    elif [[ $1 = "bld-kz" ]]; then
        echo "Set BLD (KZ) DNS"
        networksetup -setdnsservers Wi-Fi 212.19.134.52 
        # 188.130.234.184
    elif [[ $1 = "bld" ]]; then
        echo "Set BLD (EU) DNS"
        networksetup -setdnsservers Wi-Fi 135.125.204.230 49.12.234.130
    elif [[ $1 = "a-bld" ]]; then
        echo "Set A-BLD) DNS"
        networksetup -setdnsservers Wi-Fi 88.210.11.120 109.234.39.72 
    elif [[ $1 = "-h" ]]; then
            echo -e "Use: with argument - bld or doh if empty will set Cloudflare and Google DNS"
            exit 1
    else
        echo "Set Cloudflare and Google DNS"
        networksetup -setdnsservers Wi-Fi 1.1.1.1 8.8.2.2
    fi

	
    # networksetup -setdnsservers Wi-Fi 135.125.204.230
    # networksetup -setdnsservers Wi-Fi 1.1.1.1

	echo "Current DNS servers:"
	networksetup -getdnsservers Wi-Fi

	# Flush DNS
	echo "Trying flush DNS..."
	sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache

}

main $@;
