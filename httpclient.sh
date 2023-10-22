#!/bin/bash

# Check if at least one argument is passed
if [ $# -eq 1 ]; then
    hostname=$1
else
    echo "Syntax: ./httpclient.sh hostname"
    exit 1
fi

# Initialize variables for statistics
total_requests=0
total_time=0

# Function to calculate and display statistics
display_statistics() {
    if [ $total_requests -gt 0 ]; then
        average_time=$(bc -l <<< "scale=2; $total_time / $total_requests")
        echo "Statistics after $total_requests requests:"
        echo "Total Time: $total_time seconds"
        echo "Average Time per Request: $average_time seconds"
    fi
    exit 0
}

# Set up a trap for Ctrl+C to call the statistics function
trap 'display_statistics' SIGINT

while true; do
    response_time=$(curl -o /dev/null -s -w '%{time_total}\n' "$hostname:8080")
    # Check the exit code of the command
    if [ $? -ne 0 ]; then
        echo "curl execution failed"
        exit 1
    fi

    # Update statistics
    total_requests=$((total_requests + 1))
    total_time=$(bc -l <<< "scale=2; $total_time + $response_time")

    sleep 1
done
