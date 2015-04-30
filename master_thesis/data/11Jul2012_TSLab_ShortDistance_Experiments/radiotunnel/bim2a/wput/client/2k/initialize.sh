#!/bin/bash

CAPTURE_FILE=radio0_uhf.raw
STDOUT_FILE=radiotunnel_uhf_stdout.txt
EVENT_FILE=radiotunnel_uhf-event.log

rm -rf $CAPTURE_FILE
rm -rf $STDOUT_FILE
rm -rf $EVENT_FILE
touch $CAPTURE_FILE
chmod 666 $CAPTURE_FILE
sudo radiotunnel_uhf radio0 10.0.0.4/24 /dev/ttyUSB0 >> $STDOUT_FILE&
sleep 3
sudo tshark -i radio0 -w $CAPTURE_FILE
