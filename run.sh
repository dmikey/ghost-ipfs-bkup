#!/bin/bash

# prep ghost stuff from entry point script
/usr/local/bin/docker-entrypoint.sh

# run restore
/usr/local/bin/restore.sh

# Set the path to the script you want to run as a cron job
script_path=/usr/local/bin/backup.sh


# Add the cron job to the current user's crontab
(crontab -l ; echo "*/2 * * * * $script_path >> /var/log/daily-backup.log") | crontab -

# start ghost
crond && node current/index.js