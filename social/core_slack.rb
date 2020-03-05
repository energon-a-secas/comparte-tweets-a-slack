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

  def private(user)
    dm = @client.conversations_open users: user
    dm.channel.id
  end

  def send_to_channel(text, channel = '#persa', icon_emoji = ':rat:', username = 'Persiabot')
    @client.chat_postMessage channel: channel,
                             icon_emoji: icon_emoji,
                             username: username,
                             text: text
  end
end
