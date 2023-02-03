#!/bin/bash

# prep ghost stuff from entry point script
baseDir="$GHOST_INSTALL/content.orig"
for src in "$baseDir"/*/ "$baseDir"/themes/*; do
    src="${src%/}"
    target="$GHOST_CONTENT/${src#$baseDir/}"
    mkdir -p "$(dirname "$target")"
    if [ ! -e "$target" ]; then
        tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
    fi
done

# run restore
/usr/local/bin/restore.sh

# Set the path to the script you want to run as a cron job
script_path=/usr/local/bin/backup.sh

# backup every 15 minutes
(crontab -l ; echo "*/15 * * * * $script_path >> /var/log/daily-backup.log") | crontab -

# start ghost
crond && node current/index.js