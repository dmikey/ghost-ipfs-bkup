FROM ghost:5.33.5-alpine

RUN apk add --no-cache aws-cli gnupg

COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

COPY ./backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

COPY ./restore.sh /usr/local/bin/restore.sh
RUN chmod +x /usr/local/bin/restore.sh

ENV S3_HOST="${S3_HOST:-https://s3.filebase.com}"
ENV database__client=sqlite3
ENV database__connection__filename=content/data/ghost.db

## run script
CMD ["run.sh"]