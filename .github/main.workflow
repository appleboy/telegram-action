workflow "Send Notification" {
  on = "push"
  resolves = ["Post message to Telegram"]
}

action "Post message to Telegram" {
  uses = "appleboy/telegram-action@master"
  secrets = [
    "TELEGRAM_TOKEN",
    "TELEGRAM_TO",
  ]
  args = "Hello World!"
}
