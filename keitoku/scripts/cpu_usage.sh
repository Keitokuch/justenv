#! /usr/bin/env bash

awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else {printf "%.1f%%", (u-u1) * 100 / (t-t1);} }' <(grep 'cpu ' /proc/stat) <(sleep 5;grep 'cpu ' /proc/stat)
