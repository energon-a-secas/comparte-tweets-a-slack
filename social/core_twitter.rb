require 'twitter'
require './credentials'
require './social/core_slack'

# Class for all interactions related to twitter
class CoreTwitter < Credentials
  def initialize(token = nil)
    @client ||= Twitter::Streaming::Client.new(token.nil? ? twitter_token : token)
  end

  def share_url(url)
    slack = CoreSlack.new
    slack.send_to_channel(url)
  end

  def streaming(account, ignore = '_+!')
    print "Reading tweets from #{account}"
    @client.filter(follow: account) do |tweet|
      if tweet.user.id == account.to_i && tweet.text.match(ignore).nil?
        share_url(tweet.url)
      end
    end
  rescue StandardError
    sleep(800)
    retry
  end

  def from_location(coordinates)
    p coordinates
  end
end
