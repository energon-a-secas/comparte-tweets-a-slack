require 'twitter'
require './credentials'
require './social/core_slack'

# Class for all interactions related to twitter
class CoreTwitter < Credentials
  def initialize(output = 'slack', token = nil)
    @social_media = output
    @client ||= Twitter::Streaming::Client.new(token.nil? ? twitter_token : token)
  end

  def to_slack
    slack = CoreSlack.new
    slack.send_channel_message(@tweet.url)
  end

  def share_tweet
    case @social_media
    when 'slack'
      to_slack
    else
      print "#{@tweet.text}\n"
    end
  end

  def streaming(account, pattern = '(.*)', filter = '^(RT @|@)')
    print "Reading tweets from #{account}"
    @client.filter(follow: account) do |tweet|
      text = tweet.text
      if tweet.user.id == account.to_i && text.match(pattern) && text.match(filter).nil?
        @tweet = tweet
        share_tweet
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
