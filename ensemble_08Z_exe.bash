#!/bin/bash

# Bash version of the opertional loop
# ----- Yingkai (Kyle) Sha

filename='shaG_history.log'
current_time=$(date -u +%Y%m%d%H)
day0=1; #count=0
while [ 1 -le 2 ]
do
    # get the current datetime
    current_time=$(date +%Y%m%d%H)
    day=$[10#${current_time:6:2}]
    delta_day=$[$day0 - $day]
    if [ $delta_day -gt 0 ]; then
        delta_day=-1
    fi
    if [ $delta_day -ne 0 ]; then
        python ensemble_main.py $[$delta_day + 1] $day0 '08'
        py_out=$(cat $filename)
        day0_new=$[10#${py_out:0:2}]
        if [ $day0_new -eq $day0 ]; then
            echo 'BASH: Waiting for new files. Sleep 10min ...'
            sleep 600
        else
            day0=$day0_new
        fi
    else
        echo 'BASH: Current hour job is done. Sleep 10min ...'
        sleep 600
    fi
done
