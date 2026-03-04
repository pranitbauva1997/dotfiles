#!/bin/bash
if command -v acpi >/dev/null 2>&1; then
    battery=$(acpi -b 2>/dev/null | awk -F', ' '{print $2}')
    if [ -n "$battery" ]; then
        echo "$battery | "
    fi
fi
