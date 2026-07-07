#!/bin/bash

check_service() {
	echo "Checking Cron Service..."
	systemctl status cron --no-pager
}

check_service
