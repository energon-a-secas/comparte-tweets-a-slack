require 'slack-ruby-client'
require './credentials'

# Class for all interactions related to Slack
class CoreSlack < Credentials
  def initialize(token = nil)
    slack_set_config

    Slack.configure do |config|
      config.token = token.nil? ? @bot_token : token
      config.raise 'Missing token' unless config.token
    end

    @client ||= Slack::Web::Client.new
  end

  def user_content(text, filter = nil)
    if filter.is_a?(Integer)
      slack_users.each do |u, f|
        @client.send_direct_message(text, u) if text.match(f[filter])
      end
    else
      text.match(filter).captures
    end
  rescue StandardError => e
    print "User content error: #{e.message}"
  end

  def direct_message_id(user)
    dm = @client.conversations_open users: user
    dm.channel.id
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end

  def send_direct_message(text, user)
    dm = direct_message_id(user)
    send_channel_message(text, dm)
  end

  def send_channel_message(text, channel = @bot_channel, icon_url = @bot_icon, username = @bot_name)
    @client.chat_postMessage channel: channel,
                             icon_url: icon_url,
                             username: username,
                             text: text
  rescue Slack::Web::Api::Errors::SlackError => e
    print e.message
    false
  end
end
