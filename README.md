# 🚀 Telegram for GitHub Actions

[繁體中文](./README.zh-tw.md) | [简体中文](./README.zh-cn.md)

[GitHub Action](https://github.com/features/actions) for sending Telegram notification messages.

![notification](./images/telegram-notification.png)

[![Actions Status](https://github.com/appleboy/telegram-action/workflows/telegram%20message/badge.svg)](https://github.com/appleboy/telegram-action/actions)

## Usage

**Note**: If you receive the "Error: Chat not found" error, please refer to this StackOverflow answer [here](https://stackoverflow.com/a/41291666).

Send a custom message and view the custom variables below.

```yml
name: telegram message
on: [push]
jobs:

  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: send telegram message on push
        uses: appleboy/telegram-action@master
        with:
          to: ${{ secrets.TELEGRAM_TO }}
          token: ${{ secrets.TELEGRAM_TOKEN }}
          message: |
            ${{ github.actor }} created commit:
            Commit message: ${{ github.event.commits[0].message }}
            
            Repository: ${{ github.repository }}
            
            See changes: https://github.com/${{ github.repository }}/commit/${{github.sha}}
```

Remove `args` to send the default message.

```yml
- name: send default message
  uses: appleboy/telegram-action@master
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
```

![workflow](./images/telegram-workflow.png)

## Input variables

| Variable                 | Description                                                                                                             |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| socks5                   | optional. Support socks5 proxy URL                                                                                      |
| photo                    | optional. Photo message                                                                                                 |
| document                 | optional. Document message                                                                                              |
| sticker                  | optional. Sticker message                                                                                               |
| audio                    | optional. Audio message                                                                                                 |
| voice                    | optional. Voice message                                                                                                 |
| location                 | optional. Location message                                                                                              |
| venue                    | optional. Venue message                                                                                                 |
| video                    | optional. Video message                                                                                                 |
| debug                    | optional. Enable debug mode                                                                                             |
| format                   | optional. `markdown` or `html`. See [MarkdownV2 style](https://core.telegram.org/bots/api#markdownv2-style)             |
| message                  | optional. Custom message                                                                                                |
| message_file             | optional. Overwrite the default message template with the contents of the specified file.                               |
| disable_web_page_preview | optional. Disables link previews for links in this message. Default is `false`.                                         |
| disable_notification     | optional. Disables notifications for this message, supports sending a message without notification. Default is `false`. |

## Example

Send photo message:

```yml
- uses: actions/checkout@master
- name: send photo message
  uses: appleboy/telegram-action@master
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: send photo message
    photo: tests/github.png
    document: tests/gophercolor.png
```

Send location message:

```yml
- name: send location message
  uses: appleboy/telegram-action@master
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    location: '24.9163213 121.1424972'
    venue: '35.661777 139.704051 竹北體育館 新竹縣竹北市'
```

Send message using custom proxy (support `http`, `https`, and `socks5`) like `socks5://127.0.0.1:1080` or `http://222.124.154.19:23500`

```yml
- name: send message using socks5 proxy URL
  uses: appleboy/telegram-action@master
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    socks5: "http://222.124.154.19:23500"
    message: Send message from socks5 proxy URL.
```

## Secrets

Getting started with [Telegram Bot API](https://core.telegram.org/bots/api).

* `token`: Telegram authorization token.
* `to`: Unique identifier for this chat.

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
| ----------------- | -------------------------- |
| GITHUB_REPOSITORY | repo                       |
| GITHUB_ACTOR      | repo.namespace             |
| GITHUB_SHA        | commit.sha                 |
| GITHUB_REF        | commit.ref                 |
| GITHUB_WORKFLOW   | github.workflow            |
| GITHUB_ACTION     | github.action              |
| GITHUB_EVENT_NAME | github.event.name          |
| GITHUB_EVENT_PATH | github.event.path          |
| GITHUB_WORKSPACE  | github.workspace           |
