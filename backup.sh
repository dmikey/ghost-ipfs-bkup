#!/bin/bash
s3_uri_base="s3://${S3_PATH}"
aws_args="--endpoint-url ${S3_HOST}"
backup_path=$GHOST_CONTENT
now=$(date +"%T")

echo "starting backup.... $now"

aws $aws_args s3 cp "${backup_path}/images" "${s3_uri_base}/images" --recursive --exclude "*" --include "*.*"

gpg --symmetric --batch --passphrase "$KEY_PASSWORD" "${backup_path}/data/ghost.db"
aws $aws_args s3 cp "${backup_path}/data/" "${s3_uri_base}/data" --recursive --exclude "*" --include "*.gpg"
rm "${backup_path}/data/ghost.db.gpg"

now=$(date +"%T")
echo "complete backup.... $now"