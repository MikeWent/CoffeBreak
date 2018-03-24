#!/bin/bash
IPv4_WHITELIST=$(curl -s https://www.cloudflare.com/ips-v4)

if [ "$1" = "reset" ]; then
	for ip in $IPv4_WHITELIST; do
        	sudo ufw delete allow from $ip to any port 80
	done
	exit 0
fi

for ip in $IPv4_WHITELIST; do
	sudo ufw allow from $ip to any port 80
done

