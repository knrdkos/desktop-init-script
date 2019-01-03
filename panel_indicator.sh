#!/bin/bash

free -m | awk 'NR==2{printf "MEM:%.0f%% ", $3*100/$2 }'

echo CPU: $[100-$(vmstat 1 2|tail -1|awk '{print $15}')]%

#ifconfig enp37s0 | grep "inet " |  awk '{print IP:$2}'


