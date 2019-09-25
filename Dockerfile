FROM appleboy/drone-telegram:1.4.2-linux-amd64

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
