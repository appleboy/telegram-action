# 🚀 Telegram for GitHub Actions

[GitHub Action](https://developer.github.com/actions/) for sending a Telegram notification message.

<img src="./images/telegram-notification.png">

## Usage

```
action "Post message to Telegram" {
  uses = "appleboy/telegram-action@master"
  secrets = [
    "TELEGRAM_TOKEN",
    "TELEGRAM_TO",
  ]
  args = "A new commit has been pushed."
}
```

## Secrets

Getting started with [Telegram Bot API](https://core.telegram.org/bots/api).

* `TELEGRAM_TOKEN`: Telegram authorization token.
* `TELEGRAM_TO`: Unique identifier for this chat.

How to get unique identifier from telegram api:

```
$ curl https://api.telegram.org/bot<token>/getUpdates
```

See the result: (get chat id like `65382999`)

```json
{
  "ok": true,
  "result": [
    {
      "update_id": 664568113,
      "message": {
        "message_id": 8423,
        "from": {
          "id": 65382999,
          "is_bot": false,
          "first_name": "Bo-Yi",
          "last_name": "Wu (appleboy)",
          "username": "appleboy46",
          "language_code": "en"
        },
        "chat": {
          "id": 65382999,
          "first_name": "Bo-Yi",
          "last_name": "Wu (appleboy)",
          "username": "appleboy46",
          "type": "private"
        },
        "date": 1550333434,
        "text": "?"
      }
    }
  ]
}
```
