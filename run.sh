#!/bin/bash

baseDir="$GHOST_INSTALL/content.orig"
for src in "$baseDir"/*/ "$baseDir"/themes/*; do
    src="${src%/}"
    target="$GHOST_CONTENT/${src#$baseDir/}"
    mkdir -p "$(dirname "$target")"
    if [ ! -e "$target" ]; then
        tar -cC "$(dirname "$src")" "$(basename "$src")" | tar -xC "$(dirname "$target")"
    fi
done

rm -rf "$GHOST_CONTENT/data/ghost.db"

# run restore
/usr/local/bin/restore.sh

# Set the path to the script you want to run as a cron job
script_path=/usr/local/bin/backup.sh


# Add the cron job to the current user's crontab
(crontab -l ; echo "*/2 * * * * $script_path >> /var/log/daily-backup.log") | crontab -

# start ghost
crond && node current/index.js