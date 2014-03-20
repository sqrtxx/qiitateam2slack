# Slack Notification of Qiita:Team

![](https://lh4.googleusercontent.com/-g2c6JlzXMWo/Uysf2sgnY1I/AAAAAAAADaI/moVrC-RN2PI/w514-h64-no/2014-03-21_2_03_14.png)

## 概要

Qiita:Team の新着投稿を Slack に通知する.

## 使い方

1. このリポジトリを落とす
- ``gem install qiita``
- ``settings.yml`` を作成する
- crontab などで定期的に叩く

### settings.yml を作成する

``qiitateam2slack.rb`` と同じディレクトリに ``settings.yml`` を置く.
Qiita の token key は以下のコマンドで取得する.

```bash
curl -X POST https://qiita.com/api/v1/auth\?url_name\=ユーザーネーム\&password\=パスワード
```

以下はテンプレート.

```settings.yml
# Basic Settings
cron_interval: 60 # cron の間隔 (ここで指定された分数前の投稿まで取得されます)

# Qiita Settings
qiita_team_name: "abcde" # Qiita:Team の名前
qiita_token_key: "fkjdsaljfldkasjlfaskir93k" # Qiita の token key
qiita_user_list: ["sqrtxx", "hage"] # Qiita:Team のユーザーリスト

# Slack Settings
slack_webhook_url:  "https://abcde.slack.com/services/hooks/incoming-webhook?token=ABCDEFGHIJKLMN" # webhook の URL
```
