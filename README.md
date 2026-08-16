# 🚀 Telegram for GitHub Actions

[繁體中文](./README.zh-tw.md) | [简体中文](./README.zh-cn.md)

[GitHub Action](https://github.com/features/actions) for sending Telegram notification messages.

![notification](./images/telegram-notification.png)

[![Actions Status](https://github.com/appleboy/telegram-action/workflows/telegram%20message/badge.svg)](https://github.com/appleboy/telegram-action/actions)
[![GitHub Release](https://img.shields.io/github/v/release/appleboy/telegram-action)](https://github.com/appleboy/telegram-action/releases)
[![License](https://img.shields.io/github/license/appleboy/telegram-action)](./LICENSE)

## Usage

Send a custom message on every push:

```yml
name: telegram message
on: [push]
jobs:

  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: send telegram message on push
        uses: appleboy/telegram-action@v1
        with:
          to: ${{ secrets.TELEGRAM_TO }}
          token: ${{ secrets.TELEGRAM_TOKEN }}
          message: |
            ${{ github.actor }} created commit:
            Commit message: ${{ github.event.commits[0].message }}

            Repository: ${{ github.repository }}

            See changes: https://github.com/${{ github.repository }}/commit/${{github.sha}}
```

Remove the `message` input to send the default message, which looks like:

```text
appleboy/telegram-action/telegram message triggered by appleboy (push)
```

![workflow](./images/telegram-workflow.png)

> `@v1` follows the latest `v1.x` release. Pin an exact version such as
> `appleboy/telegram-action@v1.1.1` if you want fully reproducible builds.

## Setup

### 1. Create a Telegram bot

Talk to [@BotFather](https://t.me/BotFather) in Telegram, send `/newbot`, and
follow the prompts. BotFather replies with the bot token — this is your
`TELEGRAM_TOKEN` secret. See the [Telegram Bot API](https://core.telegram.org/bots/api)
for details.

### 2. Get the chat ID

First send any message to your bot (for a group or channel, add the bot as a
member and post a message there), then call:

```bash
curl https://api.telegram.org/bot<token>/getUpdates
```

Read the chat ID from `result[].message.chat.id` — this is your `TELEGRAM_TO`
secret.

- A **private chat** ID is a positive number, e.g. `65382999`.
- A **group / supergroup / channel** ID is negative and usually starts with
  `-100`, e.g. `-1001234567890`. Use the numeric ID; usernames like
  `@channelname` are not supported.
- If `getUpdates` returns an empty result, send a fresh message in the chat
  and call it again.

**Note**: the "Error: Chat not found" error means the chat ID is wrong or the
bot has never been added to that chat. See also this
[StackOverflow answer](https://stackoverflow.com/a/41291666).

<details>
<summary>Example <code>getUpdates</code> response</summary>

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

</details>

### 3. Add the secrets to your repository

In your repository go to **Settings → Secrets and variables → Actions** and
add `TELEGRAM_TOKEN` and `TELEGRAM_TO`.

## Input variables

| Variable                 | Description                                                                                                             |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| to                       | **required**. Chat ID of the target chat. Send to several chats with a comma-separated list, e.g. `65382999,-1001234567890`. |
| token                    | **required**. Telegram bot authorization token.                                                                         |
| message                  | optional. Custom message. Falls back to the default message when empty.                                                 |
| message_file             | optional. Overwrite the default message template with the contents of the specified file. Requires `actions/checkout`.  |
| message_thread_id        | optional. Unique identifier for the target message thread (topic) of the forum; for forum supergroups only.             |
| format                   | optional. `markdown` or `html`. Plain text when empty. See [message formatting](#message-formatting) below.             |
| photo                    | optional. Photo file path(s). Comma-separated list, glob patterns supported. Requires `actions/checkout`.               |
| document                 | optional. Document file path(s). Comma-separated list, glob patterns supported. Requires `actions/checkout`.            |
| sticker                  | optional. Sticker file path(s). Comma-separated list, glob patterns supported. Requires `actions/checkout`.             |
| audio                    | optional. Audio file path(s). Comma-separated list, glob patterns supported. Requires `actions/checkout`.               |
| voice                    | optional. Voice file path(s). Comma-separated list, glob patterns supported. Requires `actions/checkout`.               |
| video                    | optional. Video file path(s). Comma-separated list, glob patterns supported. Requires `actions/checkout`.               |
| location                 | optional. Location as `latitude longitude`, e.g. `24.9163213 121.1424972`.                                              |
| venue                    | optional. Venue as `latitude longitude title address`.                                                                  |
| disable_web_page_preview | optional. Disables link previews for links in this message. Default is `false`.                                         |
| disable_notification     | optional. Sends the message silently, without a notification sound. Default is `false`.                                 |
| socks5                   | optional. Custom proxy URL (`http`, `https`, or `socks5`).                                                              |
| debug                    | optional. Enable debug mode. Default is `false`.                                                                        |

## Examples

Send a photo and a document (file inputs need `actions/checkout` so the files
exist in the workspace):

```yml
- uses: actions/checkout@v7
- name: send photo message
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: send photo message
    photo: tests/github.png
    document: tests/gophercolor.png
```

Send a message from a file:

```yml
- uses: actions/checkout@v7
- name: send message file
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message_file: tests/message.txt
```

Send the same message to several chats:

```yml
- name: notify several chats
  uses: appleboy/telegram-action@v1
  with:
    to: "65382999,-1001234567890"
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: deploy finished
```

Send a location message:

```yml
- name: send location message
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    location: '24.9163213 121.1424972'
    venue: '35.661777 139.704051 竹北體育館 新竹縣竹北市'
```

Send a message to a specific forum topic (thread):

```yml
- name: send message to forum topic
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message_thread_id: 42
    message: Hello from GitHub Actions!
```

Send message using a custom proxy (supports `http`, `https`, and `socks5`),
like `socks5://127.0.0.1:1080` or `http://222.124.154.19:23500`:

```yml
- name: send message using socks5 proxy URL
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    socks5: "http://222.124.154.19:23500"
    message: Send message from socks5 proxy URL.
```

## Message formatting

With `format: markdown` the message is sent using Telegram's legacy
[Markdown style](https://core.telegram.org/bots/api#markdown-style).
Underscores are escaped automatically, but unbalanced `*`, `` ` ``, or `[`
characters (for example in a commit message) make the Telegram API reject the
whole message with a "can't parse entities" error. For messages with
unpredictable content, prefer `format: html` or plain text (no `format`).

## Template variables

The `message` and `message_file` inputs are rendered as templates: `{{ ... }}`
placeholders are replaced with values taken from the environment.

```yml
- name: send message with template variables
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: |
      Commit {{ commit.sha }} on {{ commit.ref }}
      triggered by {{ repo.namespace }}
```

| GitHub Variable   | Telegram Template Variable |
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
