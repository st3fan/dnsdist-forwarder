FROM alpine:3.20

RUN apk add --no-cache dnsdist ca-certificates \
    && update-ca-certificates

COPY dnsdist.conf /etc/dnsdist/dnsdist.conf

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["/usr/bin/dnsdist", \
    "--supervised", \
    "--disable-syslog", \
    "-u", "dnsdist", \
    "-g", "dnsdist", \
    "-C", "/etc/dnsdist/dnsdist.conf"]
