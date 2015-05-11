#!/bin/bash
for((i=0; i<16; i++))
do
	/usr/bin/time -f "\ncommand=%C\nelapsed %E\nexit status %x\n" -a -o wput2k.log wput text2k.txt ftp://alpsayin:noseArt_628@10.0.0.12/measurements/soundmodem/text2k.txt -v -a wput2k.log
	sleep 10
done
