#!/bin/bash
s3_uri_base="s3://${S3_PATH}"
aws_args="--endpoint-url ${S3_HOST}"
backup_path=$GHOST_CONTENT
now=$(date +"%T")

echo "starting restore.... $now"

# restore db
aws $aws_args s3 cp "${s3_uri_base}/data" "${backup_path}/data" --recursive --exclude "*" --include "*.gpg"
gpg --decrypt --batch --passphrase "$KEY_PASSWORD" "${backup_path}/data/ghost.db.gpg" > "${backup_path}/data/ghost.db"
rm "${backup_path}/data/ghost.db.gpg"

# restore images
aws $aws_args s3 cp "${s3_uri_base}/images" "${backup_path}/images" --recursive --exclude "*" --include "*.*"

now=$(date +"%T")
echo "complete restore.... $now"