FROM alpine:3.5

LABEL maintainer "sshnaidm <einarum@gmail.com>"
LABEL description "Docker image of PostgreSQL database based on Alpine Linux"

ENV PG_VERSION 9.6.4-r0
ENV PGDATA /var/lib/postgresql/data
ENV LANG en_US.utf8


RUN apk update && \
    apk add --no-cache bash curl \
    postgresql=$PG_VERSION postgresql-contrib=$PG_VERSION && \
    curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    apk del curl && \
    rm -rf /var/cache/apk/*


VOLUME /var/lib/postgresql/data
EXPOSE 5432

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["postgres"]
