#!/bin/bash

if ! [ -x "$(command -v iperf)" ]; then
    echo "ERROR: This script requires iperf"
    echo
    exit 1
fi

if [ "$#" -eq "2" ]; then
    runs=$1
    host=$2
else
    echo "ERROR: Script needs 2 arguments:"
    echo
    echo "1. Number of times to repeat test (e.g. 10)"
    echo "2. Host running 'iperf -s' (e.g. somehost)"
    echo
    echo "For example, this will run the test 10 times and report totals and average:"
    echo "  $(basename $0) 10 somehost"
    echo
    exit 1
fi

log=iperf.$host.log

if [ -f $log ]; then
    echo "Removing $log"
    rm $log
fi

echo "========================================================================"
echo " Results"
echo "========================================================================"
echo " Target Host ... $host"
echo "------------------------------------------------------------------------"

for run in $(seq 1 $runs); do
    sleep 3
    iperf -c $host -f m -t 10 -P 1 >> $log
    echo -e " Run $run: \t $(awk '/Bandwidth/ {getline}; END{print $7, $8}' $log)"
done

avg=$(awk -v runs=$runs '/Bandwidth/ {getline; sum+=$7; avg=sum/runs} END {print avg}' $log)

echo "------------------------------------------------------------------------"
echo " Average ....... $avg Mbits/sec"
echo
echo "See $log for details"
echo

# vi: set ts=4 sts=4 sw=4 et ft=sh: 
