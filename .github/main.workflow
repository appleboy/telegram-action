workflow "Send Notification" {
  on = "push"
  resolves = [
    "Send Custom Message",
    "Send Default Message",
    "Send Photo Message",
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
  env = {
    A = "A"
    B = "B"
  }
}

action "Send Photo Message" {
  uses = "appleboy/telegram-action@master"
  env = {
    PHOTO = "tests/github.png"
    DOCUMENT = "tests/gophercolor.png"
  }
  secrets = [
    "TELEGRAM_TOKEN",
    "TELEGRAM_TO",
  ]
  args = "send photo message."
}
