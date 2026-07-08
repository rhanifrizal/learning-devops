#!/bin/bash

echo "============================"
echo "SERVER MONITOR"
echo "============================"
echo

echo "Date:"
date
echo

echo "Hostname:"
hostname
echo

echo "Current User:"
whoami
echo

echo "IP Address:"
hostname -I
echo

echo "Disk Usage:"
df -h
echo

echo "Memory Usage:"
free -h
echo

echo "CPU Load:"
uptime
echo

echo "Running Processes:"
ps
echo

echo "Cron Status:"
systemctl status cron --no-pager
echo

echo "============================"
echo "HEALTH CHECK COMPLETE"
echo "============================"
