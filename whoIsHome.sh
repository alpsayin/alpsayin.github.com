#!/bin/sh
# OpenWrt whoIsHome script

deviceName="wlan0"
dhcpReservationFile="/etc/config/dhcp"
dhcpLeasesFile="/tmp/dhcp.leases"

echo `date`
clients=`iw dev $deviceName station dump | awk '{ if($1 == "Station" ) print $2 }'`
for client in $clients
do
	# staticHostname=`awk -v client=$client '{ if($1=="option" && $2=="mac") { if($3=="\x27"client"\x27" ) { print lastName } }; if($1=="option" && $2=="name") lastName=$3 }' $dhcpReservationFile`
	leaseIp=`awk -v client=$client '{ if($2==client) { print $3 } }' $dhcpLeasesFile`
	leaseHostname=`awk -v client=$client '{ if($2==client) { print "\x27"$4"\x27" } }' $dhcpLeasesFile`
	
	echo -e "Mac Address\t->\t$client"
	echo -e "Ip Address\t->\t$leaseIp"
	if [[ "$staticHostname" != "$leaseHostname" && -z "staticHostname" ]]
	then
		echo -e "Static Hostname\t->\t$staticHostname \nLease Hostname\t->\t$leaseHostname \n";
	else
		echo -e "Hostname\t->\t$leaseHostname \n"
	fi
done
