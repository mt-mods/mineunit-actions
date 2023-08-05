FROM mineunit/mineunit:latest

USER root
ENV USER=root

RUN apk add --no-cache bash

COPY scripts /scripts
RUN chmod -R +x /scripts

ENTRYPOINT ["/scripts/entrypoint.sh"]
