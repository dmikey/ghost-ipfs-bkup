FROM ghost:5.12.3

COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

## run script
CMD ["run.sh"]