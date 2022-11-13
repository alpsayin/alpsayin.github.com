#!/bin/bash
for((i=0; i<16; i++))
do
	/usr/bin/time -f "\ncommand=%C\nelapsed %E\nexit status %x\n" -a -o wget127.log wget http://10.0.0.1/text127.txt -v -a wget127.log
	sleep 10
done
