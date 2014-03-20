# -*- coding: utf-8 -*-
require 'qiita'
require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require 'time'

SETTINGS = YAML.load_file("./settings.yml")
qiita = Qiita.new token: SETTINGS['qiita_token_key']

def post(text)
  data = {
          "text" => text
         }
  uri = URI.parse(SETTINGS['slack_webhook_url'])
  Net::HTTP.post_form(uri, {"payload" => data.to_json})
end

SETTINGS['qiita_user_list'].each do |user|
  items = qiita.user_items user, team_url_name: SETTINGS['qiita_team_name']
  items.select {|item| Time.parse(item.created_at) > (Time.now - SETTINGS['cron_interval'] * 60)}.each do |item|
    text = <<-EOF
#{item.user.url_name} wrote #{item.title} <#{item.url}>
at #{item.created_at_in_words}
EOF
    post(text)
  end
end


