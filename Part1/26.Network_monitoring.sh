#!/bin/bash
LOG=ping.log
PREFIX=192.168.1
for i in $(seq 254)
do
  ping -c1 -w1 ${PREFIX}.$i && \
    echo "${PREFIX}.$i is alive" | tee -a $LOG || \
    echo "${PREFIX}.$i is dead" | tee -a $LOG &
done
