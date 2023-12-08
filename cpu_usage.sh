#!/bin/bash

while true; do
cpu_usage=$(top -bn1 | awk '/%Cpu/ {print "usage: "$2"%, System: "$4"%, Idle: "$8}')
echo "<p> CPU $cpu_usage </p>" > /var/www/html/cpu_script/cpu.html
sleep 1
done


