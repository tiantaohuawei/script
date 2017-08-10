#!/bin/bash
n=0
while :
do
	n=$((n+1))
	echo "test count=" $n
	./bmc.sh
	sleep 10m
done
