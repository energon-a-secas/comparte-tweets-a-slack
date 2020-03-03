require 'twitter'
require './config/yaml_config'
require './social/core_slack'

module CoreTwitter
  include Credentials

  def self.find_tweets
    load_credentials
    begin
    threads = []
    @accounts.each do |account, v|
      threads << Thread.new do
        client = Twitter::Streaming::Client.new(@twitter_tokens)
        p "Reading tweets from #{account}"
        client.filter(follow: v[0]) do |tweet|
          if tweet.user.id == v[0].to_i
            slack = CoreSlack.new(@slack_token)
            slack.send_to_channel(tweet.uri)
          end
        end
      end
      threads.each(&:join)
    end
    rescue StandardError
      sleep(800)
      retry
    end
  end
end

CoreTwitter.find_tweets
