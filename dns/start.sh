#!/bin/bash
docker run \
	       --name dnsmasq \
	       -d \
	       -p 53:53/udp \
	       -p 8080:8080 \
	       -v $PWD/dnsmasq.conf:/etc/dnsmasq.conf \
	       -v $PWD/dnsmasq.hosts:/etc/dnsmasq.hosts \
	       -v $PWD/dnsmasq.resolv.conf:/etc/dnsmasq.resolv.conf \
	       --log-opt "max-size=100m" \
	       -e "HTTP_USER=admin" \
	       -e "HTTP_PASS=adminpassword" \
	       --restart always \
	       jpillora/dnsmasq  
