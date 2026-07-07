#!/bin/bash

echo "===== Server Health Script ====="
echo

echo "Date:"
date +"Today is %A, %B %d, %Y"
echo

echo "Hostname:"
hostname
echo

echo "User:"
whoami
echo

echo "Current Directory:"
pwd
echo

echo "Disk Usage:"
df -h
echo

echo "Memory Usage:"
free -h
echo

echo "===== Health Check Completed ====="
