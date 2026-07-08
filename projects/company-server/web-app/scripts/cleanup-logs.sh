#!/bin/bash

echo "Cleaning old logs..."
echo

# Generate the timestamp in the YYYYMMDD format
TIMESTAMP=$(date +%Y%m%d)

# Define the name of the final compressed file
ARCHIVE_NAME="logs-backup-${TIMESTAMP}.tar.gz"

# Create an empty dummy log file to simulate an old system log
touch app-old.log

# Create a compressed tar archive of the log file
# -c: Create a new archive
# -z: Compress the archive using gzip
# -f: Specify the filename of the archive
tar -czf "$ARCHIVE_NAME" app-old.log

echo "Archive created:"
echo "$ARCHIVE_NAME"
echo

# Clean up the dummy log file after archiving
rm app-old.log

echo "Done."
