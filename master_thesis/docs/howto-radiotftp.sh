#!/bin/bash
echo ""
echo "this is a bit more complicated than soundmodem"
echo "but no worries"
echo ""
echo "now I'm going to fix the permissions of usb devices for in case"
echo "plug in all the usb serial cables(FTDI)"
read -p "[press enter to continue...]"
chmod 666 /dev/ttyUSB*
echo ""
echo "download subversion and our favorite text editor"
read -p "[press enter to continue...]"
apt-get update && apt-get install nano subversion
echo ""
echo "cd into the home directory and fetch the repository"
read -p "[press enter to continue...]"
cd ~/
svn checkout http://kth-wsn-longrange-radio-uplink.googlecode.com/svn/trunk/ wsn-uplink
echo ""
echo "cd into the repository"
cd wsn-uplink
echo ""
echo "now i'm going to create symbolic links in /sbin for further use"
read -p "[press enter to continue...]"
rm /sbin/radiotftp
rm /sbin/tty_talk
rm /sbin/sendItAway.sh
ln -s `pwd`"/project_radiotftp/Release/radiotftp" "/sbin/radiotftp"
ln -s `pwd`"/tty_talk/tty_talk" "/sbin/tty_talk"
ln -s `pwd`"/tty_talk/tty_talk" "/sbin/sensd"
ln -s `pwd`"/tty_talk/sendItAway.sh" "/sbin/sendItAway.sh"
echo ""
echo "the latest build of radiotftp is in the project_radiotftp/Release/radiotftp"
echo "but there is a symbolic link to that file directly in the folder"
echo "let's try to run it without any argument, help window should show up"
read -p "[press enter to continue...]"
radiotftp
echo ""
echo "if you see the usage, then we should be okay"
read -p "[press enter to continue...]"
echo ""
echo "now, let's cd into tty_talk directory"
echo "here lies the patched version of robert's tty_talk"
cd tty_talk
echo "let's try to run it without any arguments and have a look at the usage"
read -p "[press enter to continue...]"
tty_talk
echo ""
echo "if you see the usage, then we should be okay"
read -p "[press enter to continue...]"
echo ""
echo "do you want to run the server or the client here(s/c)"
read -n 1 server_or_client
if [ "$server_or_client" = "c" ] 
then
    echo ""
    echo "there is script called start_measurements.sh to run the tty_talk automagically"
    echo "but it needs your help to use the correct usb serial(FTDI cable)"
    echo "we're going to enter it with out favorite text editor nano"
    echo "you should replace the /dev/ttyUSB device with one that is connected to the sink mote"
    read -p "[press enter to continue...]"
    nano start_measurements.sh
    echo ""
    echo "there is a file called sendItAway.sh"
    echo "that script is responsible for actually calling the radiotftp"
    echo "now we're going to change it to use the correct usb serial cable(FTDI cable)"
    echo "you should replace the /dev/ttyUSB device with the one that is connected to the transceiver"
    read -p "[press enter to continue...]"
    nano sendItAway.sh
    echo ""
    echo "one last step"
    echo "there is a file called radiotftp.conf"
    echo "you should change the contents of this file"
    echo "it's better to have everyone with unique addresses and callsigns"
    read -p "[press enter to continue...]"
    nano radiotftp.conf
    echo ""
    echo "now I'm going to start the tty_talk and we're in business"
    echo "just in case, I'm waiting until you setup the server on the otherside"
    read -p "[press enter to continue...]"
    ./start_measurements.sh
else 
    echo ""
    echo "compared to client setup this is easier"
    echo "we just need to select the correct usb serial(FTDI cable)"
    echo "there is a script to run the radiotftp binary in repository root"
    echo "you should replace the /dev/ttyUSB string with the one that is connected to transceiver"
    cd ../
    read -p "[press enter to continue]"
    nano radiotftp_server.sh
    echo ""
    echo "one last step"
    echo "there is a file called radiotftp.conf"
    echo "you should change the contents of this file"
    echo "it's better to have everyone with unique addresses and callsigns"
    read -p "[press enter to continue...]"
    nano radiotftp.conf
    echo ""
    echo "now you can enter the path where you want your sensors.dat file"
    currentPath=`pwd`
    read -e path
    cd $path
    echo "if you think you're ready to go, I will run the server for you"
    read -p "[press enter to continue...]"    
    eval $currentPath"/radiotftp_server.sh"
fi