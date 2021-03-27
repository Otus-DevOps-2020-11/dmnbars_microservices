FROM alpine:3.13

WORKDIR /tmp/mongodb
RUN wget https://github.com/percona/mongodb_exporter/releases/download/v0.20.3/mongodb_exporter-0.20.3.linux-amd64.tar.gz && \
    tar xvzf mongodb_exporter-0.20.3.linux-amd64.tar.gz && \
    mv mongodb_exporter /usr/local/bin/. && \
    rm -rf /tmp/mongodb

WORKDIR /

CMD ["mongodb_exporter"]

