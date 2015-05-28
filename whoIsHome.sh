#!/bin/sh
# OpenWrt whoIsHome script

deviceName="wlan0"
dhcpReservationFile="/etc/config/dhcp"
dhcpLeasesFile="/tmp/dhcp.leases"

echo `date`
clients=`iw dev $deviceName station dump | awk '{ if($1 == "Station" ) print $2 }'`
for client in $clients
do
	echo $client
	awk -v client=$client '{ if($1=="option" && $2=="mac") { if($3=="\x27"client"\x27" ) { print "Static Dhcp Hostname \t->\t " lastName } }; if($1=="option" && $2=="name") lastName=$3 }' $dhcpReservationFile
	awk -v client=$client '{ if($2==client) { print $3 " \t\t->\t " "\x27"$4"\x27" } }' $dhcpLeasesFile
done
