workflow "Send Notification" {
  on = "push"
  resolves = [
    "Send Custom Message",
    "Send Default Message"
  ]
}

action "Send Custom Message" {
  uses = "appleboy/telegram-action@master"
  secrets = [
    "TELEGRAM_TOKEN",
    "TELEGRAM_TO",
  ]
  args = "A new commit has been pushed."
}

action "Send Default Message" {
  uses = "appleboy/telegram-action@master"
  secrets = [
    "TELEGRAM_TOKEN",
    "TELEGRAM_TO",
  ]
}

action "Send photo message" {
  uses = "appleboy/telegram-action@master"
  secrets = [
    "TELEGRAM_TOKEN",
    "TELEGRAM_TO",
  ]
  env = {
    PHOTO = "tests/github.png"
  }
  args = "A new commit has been pushed."
}
