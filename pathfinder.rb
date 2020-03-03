require 'twitter'
require 'yaml'
require './social/core_slack'

# Meh
class DiscountFinder
  def initialize(config_file = 'conf.yml')
    data = YAML.load_file("#{Dir.pwd}/config/#{config_file}")

    @slack_token = data['slack']['token']['test']
    @twitter_tokens = { consumer_key: data['twitter']['token']['consumer_key'], consumer_secret: data['twitter']['token']['consumer_secret'], access_token: data['twitter']['token']['access_token'], access_token_secret: data['twitter']['token']['access_token_secret'] }
    @accounts = data['twitter']['config']['follow']
  end

  def search
    multi
  rescue StandardError
    sleep(800)
    retry
  end

  def multi
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
  end
end

deals = DiscountFinder.new
deals.search
