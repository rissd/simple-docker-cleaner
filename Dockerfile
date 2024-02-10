FROM alpine:3.19

RUN apk add --no-cache docker-cli tini \
    && ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

COPY cron-files/* /cron/

COPY --chmod=700 *.sh /

ENTRYPOINT ["/sbin/tini", "-g", "--", "/docker-entrypoint.sh"]

CMD ["defautl"]

HEALTHCHECK --timeout=10s CMD ps -o comm | grep crond || exit 1
