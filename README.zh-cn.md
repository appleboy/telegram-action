# 🚀 GitHub Actions 的 Telegram

[English](./README.md) | [繁體中文](./README.zh-tw.md)

[GitHub Action](https://github.com/features/actions) 用于发送 Telegram 通知消息。

![notification](./images/telegram-notification.png)

[![Actions Status](https://github.com/appleboy/telegram-action/workflows/telegram%20message/badge.svg)](https://github.com/appleboy/telegram-action/actions)
[![GitHub Release](https://img.shields.io/github/v/release/appleboy/telegram-action)](https://github.com/appleboy/telegram-action/releases)
[![许可证](https://img.shields.io/github/license/appleboy/telegram-action)](./LICENSE)

## 使用方法

在每次 push 时发送自定义消息：

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

移除 `message` 参数则发送默认消息，格式如下：

```text
appleboy/telegram-action/telegram message triggered by appleboy (push)
```

![workflow](./images/telegram-workflow.png)

> `@v1` 会跟踪 `v1.x` 的最新版本。如需完全可复现的构建，请锁定确切版本，
> 例如 `appleboy/telegram-action@v1.1.1`。

## 设置步骤

### 1. 创建 Telegram bot

在 Telegram 中与 [@BotFather](https://t.me/BotFather) 对话，输入 `/newbot`
并按提示操作。BotFather 会回复 bot token — 这就是 `TELEGRAM_TOKEN` secret。
详见 [Telegram Bot API](https://core.telegram.org/bots/api)。

### 2. 获取 chat ID

先给你的 bot 发送任意消息（群组或频道则需把 bot 添加为成员并在其中发一条
消息），然后调用：

```bash
curl https://api.telegram.org/bot<token>/getUpdates
```

从 `result[].message.chat.id` 读取 chat ID — 这就是 `TELEGRAM_TO` secret。

- **私聊**的 ID 是正数，例如 `65382999`。
- **群组 / 超级群组 / 频道**的 ID 是负数，通常以 `-100` 开头，例如
  `-1001234567890`。请使用数字 ID，不支持 `@channelname` 这类用户名。
- 如果 `getUpdates` 返回空结果，请在聊天中重新发一条消息后再调用一次。

**注意**：出现 "Error: Chat not found" 错误说明 chat ID 有误，或 bot 从未被
添加到该聊天。也可参考这个 [StackOverflow 回答](https://stackoverflow.com/a/41291666)。

<details>
<summary><code>getUpdates</code> 响应示例</summary>

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

### 3. 将 secrets 添加到仓库

进入仓库的 **Settings → Secrets and variables → Actions**，添加
`TELEGRAM_TOKEN` 和 `TELEGRAM_TO`。

## 输入变量

| 变量                     | 描述                                                                                                    |
| ------------------------ | ------------------------------------------------------------------------------------------------------- |
| to                       | **必填**。目标聊天的 chat ID。用逗号分隔可发送到多个聊天，例如 `65382999,-1001234567890`                |
| token                    | **必填**。Telegram bot 授权 token                                                                       |
| message                  | 可选。自定义消息，留空则发送默认消息                                                                    |
| message_file             | 可选。用指定文件的内容覆盖默认消息模板，需搭配 `actions/checkout`                                       |
| message_thread_id        | 可选。论坛目标消息串（主题）的唯一标识符，仅适用于论坛超级群组                                          |
| format                   | 可选。`markdown` 或 `html`，留空为纯文本。参见下方[消息格式](#消息格式)                                 |
| photo                    | 可选。图片文件路径，可逗号分隔多个并支持 glob 模式，需搭配 `actions/checkout`                           |
| document                 | 可选。文档文件路径，可逗号分隔多个并支持 glob 模式，需搭配 `actions/checkout`                           |
| sticker                  | 可选。贴纸文件路径，可逗号分隔多个并支持 glob 模式，需搭配 `actions/checkout`                           |
| audio                    | 可选。音频文件路径，可逗号分隔多个并支持 glob 模式，需搭配 `actions/checkout`                           |
| voice                    | 可选。语音文件路径，可逗号分隔多个并支持 glob 模式，需搭配 `actions/checkout`                           |
| video                    | 可选。视频文件路径，可逗号分隔多个并支持 glob 模式，需搭配 `actions/checkout`                           |
| location                 | 可选。位置，格式为 `纬度 经度`，例如 `24.9163213 121.1424972`                                           |
| venue                    | 可选。地点，格式为 `纬度 经度 名称 地址`                                                                |
| disable_web_page_preview | 可选。禁用此消息中链接的预览。默认值为 `false`                                                          |
| disable_notification     | 可选。静默发送消息（无通知提示音）。默认值为 `false`                                                    |
| socks5                   | 可选。自定义代理 URL（`http`、`https` 或 `socks5`）                                                     |
| debug                    | 可选。启用调试模式。默认值为 `false`                                                                    |

## 示例

发送图片和文档（文件类参数需搭配 `actions/checkout`，文件才会存在于
workspace 中）：

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

从文件发送消息：

```yml
- uses: actions/checkout@v7
- name: send message file
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message_file: tests/message.txt
```

将同一消息发送到多个聊天：

```yml
- name: notify several chats
  uses: appleboy/telegram-action@v1
  with:
    to: "65382999,-1001234567890"
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: deploy finished
```

发送位置消息：

```yml
- name: send location message
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    location: '24.9163213 121.1424972'
    venue: '35.661777 139.704051 竹北體育館 新竹縣竹北市'
```

发送消息到特定论坛主题（消息串）：

```yml
- name: send message to forum topic
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message_thread_id: 42
    message: Hello from GitHub Actions!
```

使用自定义代理发送消息（支持 `http`、`https` 和 `socks5`），如
`socks5://127.0.0.1:1080` 或 `http://222.124.154.19:23500`：

```yml
- name: send message using socks5 proxy URL
  uses: appleboy/telegram-action@v1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    socks5: "http://222.124.154.19:23500"
    message: Send message from socks5 proxy URL.
```

## 消息格式

使用 `format: markdown` 时，消息会以 Telegram 的传统
[Markdown 样式](https://core.telegram.org/bots/api#markdown-style)发送。
下划线会自动转义，但未成对的 `*`、`` ` `` 或 `[` 字符（例如出现在 commit
消息中）会让 Telegram API 以 "can't parse entities" 错误拒绝整条消息。
如果消息内容不可预期，建议改用 `format: html` 或纯文本（不设置 `format`）。

## 模板变量

`message` 和 `message_file` 参数会以模板方式渲染：`{{ ... }}` 占位符会被
替换为环境中的对应值。

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

| GitHub 变量       | Telegram 模板变量 |
| ----------------- | ----------------- |
| GITHUB_REPOSITORY | repo              |
| GITHUB_ACTOR      | repo.namespace    |
| GITHUB_SHA        | commit.sha        |
| GITHUB_REF        | commit.ref        |
| GITHUB_WORKFLOW   | github.workflow   |
| GITHUB_ACTION     | github.action     |
| GITHUB_EVENT_NAME | github.event.name |
| GITHUB_EVENT_PATH | github.event.path |
| GITHUB_WORKSPACE  | github.workspace  |
