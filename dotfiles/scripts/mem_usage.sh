#!/usr/bin/env bash
free -m | awk 'NR==2{printf "%.0f%% %.1fGB", $3*100/$2, $2/1024 }'
