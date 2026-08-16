# 🚀 Telegram 的 GitHub Actions

透過 [GitHub Action](https://github.com/features/actions) 發送 Telegram 通知訊息。

![通知](./images/telegram-notification.png)

[![Actions 狀態](https://github.com/appleboy/telegram-action/workflows/telegram%20message/badge.svg)](https://github.com/appleboy/telegram-action/actions)

## 使用方式

**注意**：如果您收到 "Error: Chat not found" 錯誤，請參考此 stackoverflow 上的回答 [連結](https://stackoverflow.com/a/41291666)。

發送自訂訊息並參考以下自訂變數。

## 輸入變數

| 變數                     | 說明                                                                                                    |
| ------------------------ | ------------------------------------------------------------------------------------------------------- |
| to                       | **必填**。目標聊天的唯一標識符                                                                          |
| token                    | **必填**。Telegram 授權令牌                                                                             |
| socks5                   | 選填。支援 socks5 代理 URL                                                                              |
| photo                    | 選填。圖片訊息                                                                                          |
| document                 | 選填。文件訊息                                                                                          |
| sticker                  | 選填。貼圖訊息                                                                                          |
| audio                    | 選填。音訊訊息                                                                                          |
| voice                    | 選填。語音訊息                                                                                          |
| location                 | 選填。位置訊息                                                                                          |
| venue                    | 選填。地點訊息                                                                                          |
| video                    | 選填。影片訊息                                                                                          |
| debug                    | 選填。啟用除錯模式                                                                                      |
| format                   | 選填。`markdown` 或 `html`。參見 [MarkdownV2 格式](https://core.telegram.org/bots/api#markdownv2-style) |
| message                  | 選填。自訂訊息                                                                                          |
| message_file             | 選填。使用指定檔案的內容覆蓋預設訊息模板                                                                |
| message_thread_id        | 選填。論壇目標訊息串（主題）的唯一標識符，僅適用於論壇超級群組                                          |
| disable_web_page_preview | 選填。停用此訊息中連結的預覽。預設為 `false`                                                            |
| disable_notification     | 選填。停用此訊息的通知，支援發送無通知的訊息。預設為 `false`                                            |

## 範例

發送圖片訊息：

```yml
- uses: actions/checkout@v7
- name: send photo message
  uses: appleboy/telegram-action@v1.1.1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    message: send photo message
    photo: tests/github.png
    document: tests/gophercolor.png
```

發送位置消息：

```yml
- name: send location message
  uses: appleboy/telegram-action@v1.1.1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    location: '24.9163213 121.1424972'
    venue: '35.661777 139.704051 竹北體育館 新竹縣竹北市'
```

使用自定義代理發送消息（支持 `http`、`https` 和 `socks5`），如 `socks5://127.0.0.1:1080` 或 `http://222.124.154.19:23500`

```yml
- name: send message using socks5 proxy URL
  uses: appleboy/telegram-action@v1.1.1
  with:
    to: ${{ secrets.TELEGRAM_TO }}
    token: ${{ secrets.TELEGRAM_TOKEN }}
    socks5: "http://222.124.154.19:23500"
    message: Send message from socks5 proxy URL.
```

## Secrets

開始使用 [Telegram Bot API](https://core.telegram.org/bots/api)。

* `token`: Telegram 授權令牌。
* `to`: 此聊天的唯一標識符。

如何從 telegram api 獲取唯一標識符：

```bash
curl https://api.telegram.org/bot<token>/getUpdates
```

查看結果：（獲取聊天 ID，如 `65382999`）

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

## 模板變數

| Github 變數       | Telegram 模板變數 |
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
