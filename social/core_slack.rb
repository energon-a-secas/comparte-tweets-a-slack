require 'slack-ruby-client'
require './credentials'

# Class for all interactions related to Slack
class CoreSlack < Credentials

  def initialize(token = nil)
    Slack.configure do |config|
      config.token = token.nil? ? slack_token : token
      config.raise 'Missing token' unless config.token
    end

    @client ||= Slack::Web::Client.new
  end

  def direct_message_id(user)
    dm = @client.conversations_open users: user
    dm.channel.id
  end

  def send_direct_message(text, user)
    dm = direct_message_id(user)
    send_channel_message(text, dm)
  end

  def send_channel_message(text, channel = '#hq-alerts', icon_url = 'https://i.imgur.com/btEyTkf.png', username = 'Pathfinder')
    @client.chat_postMessage channel: channel,
                             icon_url: icon_url,
                             username: username,
                             text: text
  end
end
