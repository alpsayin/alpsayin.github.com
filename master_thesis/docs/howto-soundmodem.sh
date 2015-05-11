#!/bin/bash
echo ""
echo "install subversion, we are going to use it to fetch the scripts and codes from the repository"
echo "also install your favorite text editor, we will need to edit config files"
read -p "[press enter to continue...]"
apt-get update && apt-get install nano subversion
echo ""
echo "cd into the home directory and fetch the repository"
cd ~/
read -p "[press enter to continue...]"
svn checkout http://kth-wsn-longrange-radio-uplink.googlecode.com/svn/trunk/ wsn-uplink
echo ""
echo "now I'm going to fix the permissions of usb devices for in case"
echo "plug in all the usb serial cables(FTDI)"
read -p "[press enter to continue...]"
chmod 666 /dev/ttyUSB*
echo ""
echo "now I'm going to install soundmodem along with its dependencies"
echo "and I will also create sample configuration files"
apt-get install alsa-base alsa-oss alsa-tools alsa-utils soundmodem
mkdir -p /etc/ax25
touch /etc/ax25/soundmodem.conf
echo '<?xml version="1.0"?>
<modem>
  <configuration name="alp">
    <channel name="Channel 0">
      <mod mode="afsk" bps="1200" f0="1200" f1="2200" diffenc="1"/>
      <demod mode="afsk" bps="1200" f0="1200" f1="2200" diffdec="1"/>
      <pkt mode="MKISS" ifname="sm8" hwaddr="SA0BXI-8" ip="10.0.0.8" netmask="255.255.255.0" broadcast="10.0.0.255" file="/dev/soundmodem0" unlink="1"/>
    </channel>
    <chaccess txdelay="400" slottime="100" ppersist="40" fulldup="0" txtail="10"/>
    <audio type="alsa" device="plughw:1,0" halfdup="1" capturechannelmode="Mono"/>
    <ptt file="/dev/ttyUSB0" gpio="0"/>
  </configuration>
</modem>' > /etc/ax25/soundmodem.conf
touch /etc/ax25/axports
echo '# /etc/ax25/axports
#
# The format of this file is:
#
# name callsign speed paclen window description
#
axport8	SA0BXI-8	1200	255	32 144.8 MHz APRS (1200 bps)
' > /etc/ax25/axports
ln -s /etc/ax25/axports ~/axports
ln -s /etc/ax25/soundmodem.conf ~/soundmodem.confecho ""
echo "now it's time to edit the config files"
echo "change the addresses and callsigns according to your will"
echo "also enter the /dev/ttyUSB path of the PTT device(FTDI cable)"
read -p "[press enter to continue...]"
nano /etc/ax25/soundmodem.conf
echo ""
echo "change the port name according to your callsign(helps remembering)"
echo "but the callsign in this file MUST match the callsign in soundmodem.conf"
read -p "[press enter to continue...]"
nano /etc/ax25/axports
echo ""
echo "we are done!"
echo "when you run soundmodem your interface will show up in ifconfig"
echo "don't forget to plugin the usb audio device!"
read -p "press enter to finish..."