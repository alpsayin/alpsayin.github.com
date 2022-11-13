#!/bin/bash
for((i=0; i<16; i++))
do
	/usr/bin/time -f "\ncommand=%C\nelapsed %E\nexit status %x\n" -a -o wget2k.log wget http://10.0.0.1/text2k.txt -v -a wget2k.log
	sleep 10
done
