# -*- coding: utf-8 -*-
require 'qiita'
require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'flowdock'

SETTINGS = YAML.load_file("./settings.yml")
qiita = Qiita.new token: SETTINGS['qiita_token_key']

def post(text, subject, url)
  flow = Flowdock::Flow.new(:api_token => SETTINGS['flowdock_api_token'], :source => "Qiita:Team", :from => {:name => "Qiita:Team", :address => SETTINGS['flowdock_address']})
  flow.push_to_team_inbox(:content => text, :subject => subject, :source => "QiitaTeam", :link => url)
end

SETTINGS['qiita_user_list'].each do |user|
  items = qiita.user_items user, team_url_name: SETTINGS['qiita_team_name']
  items.select {|item| Time.parse(item.created_at) > (Time.now - SETTINGS['cron_interval'] * 60)}.each do |item|
    text = <<-EOF
#{item.user.url_name}
#{item.created_at_in_words}
EOF
    post(text, item.title, item.url)
  end
end


