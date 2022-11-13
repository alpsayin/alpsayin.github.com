#!/bin/bash
for((i=0; i<16; i++))
do
	/usr/bin/time -f "\ncommand=%C\nelapsed %E\nexit status %x\n" -a -o wput127.log wput text127.txt ftp://alpsayin:noseArt_628@10.0.0.1/measurements/radiotunnel/text127.txt -v -a wput127.log
	sleep 10
done
