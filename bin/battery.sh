#!/bin/bash
for bat in /sys/class/power_supply/BAT*; do
    if [ -d "$bat" ]; then
        capacity=$(cat "$bat/capacity" 2>/dev/null)
        status=$(cat "$bat/status" 2>/dev/null)
        if [ -n "$capacity" ]; then
            if [ "$status" = "Charging" ]; then
                echo "⚡$capacity% | "
            else
                echo "$capacity% | "
            fi
            exit 0
        fi
    fi
done
