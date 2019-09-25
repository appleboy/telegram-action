# 🚀 Telegram for GitHub Actions

[GitHub Action](https://developer.github.com/actions/) for sending a Telegram notification message.

![notification](./images/telegram-notification.png)

[![Actions Status](https://github.com/appleboy/facebook-telegram/workflows/telegram%20message/badge.svg)](https://github.com/appleboy/facebook-action/actions)

## Usage

Send custom message and see the custom variable as blow.

```yml
- name: send custom message
  uses: appleboy/telegram-action@master
  env:
    TELEGRAM_TOKEN: ${{ secrets.TELEGRAM_TOKEN }}
    TELEGRAM_TO: ${{ secrets.TELEGRAM_TO }}
  with:
    args: The ${{ github.event_name }} event triggered first step.
```

Remove `args` to send the default message.

```yml
- name: send default message
  uses: appleboy/telegram-action@master
  env:
    TELEGRAM_TOKEN: ${{ secrets.TELEGRAM_TOKEN }}
    TELEGRAM_TO: ${{ secrets.TELEGRAM_TO }}
```

![workflow](./images/telegram-workflow.png)

send location message:

```yml
- name: send location message
  uses: appleboy/telegram-action@master
  with:
    location: '24.9163213 121.1424972'
    venue: '35.661777 139.704051 竹北體育館 新竹縣竹北市'
  env:
    TELEGRAM_TOKEN: ${{ secrets.TELEGRAM_TOKEN }}
    TELEGRAM_TO: ${{ secrets.TELEGRAM_TO }}
```

## Input variables

* photo - optional. photo message
* document - optional. document message
* sticker - optional. sticker message
* audio - optional. audio message
* voice - optional. voice message
* location - optional. location message
* venue - optional. venue message
* video - optional. video message
* debug - optional. enable debug mode
* format - optional. `markdown` or `html`

### Example

```yml
- name: send photo message
  uses: appleboy/telegram-action@master
  with:
    message: send photo message
    photo: tests/github.png
    document: tests/gophercolor.png
  env:
    TELEGRAM_TOKEN: ${{ secrets.TELEGRAM_TOKEN }}
    TELEGRAM_TO: ${{ secrets.TELEGRAM_TO }}
```

## Secrets

Getting started with [Telegram Bot API](https://core.telegram.org/bots/api).

* `TELEGRAM_TOKEN`: Telegram authorization token.
* `TELEGRAM_TO`: Unique identifier for this chat.

How to get unique identifier from telegram api:

```bash
curl https://api.telegram.org/bot<token>/getUpdates
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

## Template variable

| Github Variable   | Telegram Template Variable |
|-------------------|----------------------------|
| GITHUB_REPOSITORY | repo                       |
| GITHUB_ACTOR      | repo.namespace             |
| GITHUB_SHA        | commit.sha                 |
| GITHUB_REF        | commit.ref                 |
| GITHUB_WORKFLOW   | github.workflow            |
| GITHUB_ACTION     | github.action              |
| GITHUB_EVENT_NAME | github.event.name          |
| GITHUB_EVENT_PATH | github.event.path          |
| GITHUB_WORKSPACE  | github.workspace           |
