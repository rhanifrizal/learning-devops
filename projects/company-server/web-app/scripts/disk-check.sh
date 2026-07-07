#!/bin/bash

USAGE=65

if [ "$USAGE" -gt 80 ]; then
    echo "Disk usage is high!"
else
    echo "Disk usage is healthy."
fi
