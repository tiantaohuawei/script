#!/bin/bash        
echo "start test"
n=0
cat /sys/kernel/debug/tracing/available_filter_functions | while read LINE  
do
echo $LINE $n  
echo $LINE > /sys/kernel/debug/tracing/set_ftrace_filter
echo function_graph > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/current_tracer
((n=n+1))
sleep 1
done
echo "end test"

