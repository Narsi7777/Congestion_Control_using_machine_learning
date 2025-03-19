#!/bin/bash

OUTPUT_FILE="network_metrics.csv"

# Add CSV Headers
echo "Nodes,Packets Sent,Packets Received,Packet Loss,Packet Delivery Ratio,Avg Delay,Throughput,Avg Jitter" > $OUTPUT_FILE

for i in {1..50}  # Run 50 simulations
do
    echo "${i} th Iteration start"
    NODES=$((RANDOM % 50 + 10))  # Random nodes between 10 and 50
    X=500
    Y=500
    PACKET_SIZE=1024
    RATE=$((RANDOM % 10 + 1))Mb  # Random rate between 1Mb and 10Mb

    # Run NS-2 simulation
    ns congestion.tcl $NODES $X $Y $PACKET_SIZE $RATE

    # Extract metrics using AWK and append to CSV
    awk -f metrics.awk congestion.tr | awk -v nodes=$NODES '{printf "%s,", nodes; print $0}' >> $OUTPUT_FILE
    echo "${i} th Iteration end"
done

