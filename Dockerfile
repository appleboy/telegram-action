FROM appleboy/drone-telegram

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /github/home

ENTRYPOINT ["/entrypoint.sh"]
