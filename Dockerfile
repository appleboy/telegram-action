FROM golang:1.11

# Github labels
LABEL "com.github.actions.name"="Action Telegram"
LABEL "com.github.actions.description"="Sending a Telegram notification message"
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/Ilshidur/actions"
LABEL "homepage"="https://github.com/appleboy/telegram-action"
LABEL "maintainer"="Bo-Yi Wu <appleboy.tw@gmail.com>"
LABEL "version"="0.0.1"

ENV TELEGRAM_VERSION=1.4.0
ENV OS_ARCH=linux-amd64

RUN wget https://github.com/appleboy/drone-telegram/releases/download/${TELEGRAM_VERSION}/drone-telegram-${TELEGRAM_VERSION}-${OS_ARCH} -O /bin/drone-telegram
RUN chmod +x /bin/drone-telegram

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
