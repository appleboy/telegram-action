FROM ghcr.io/appleboy/drone-telegram:1.5.2

COPY entrypoint.sh /entrypoint.sh

WORKDIR /github/workspace

ENTRYPOINT ["/entrypoint.sh"]
