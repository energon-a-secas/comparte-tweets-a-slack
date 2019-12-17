require 'slack-ruby-client'

# Groups client initialization and message sending
module WebSlack
  def configure_client(token)
    Slack.configure do |config|
      config.token = token
      config.raise 'Missing token' unless config.token
    end

    Slack::Web::Client.new
  end

  def send_to_channel(token, text, channel = '#persa', icon_emoji = ':rat:', username = 'Persiabot')
    client = configure_client(token)
    client.chat_postMessage channel: channel,
                            icon_emoji: icon_emoji,
                            username: username,
                            text: text
  end
end
