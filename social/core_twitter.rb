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
    slack.user_content(@tweet.text, 0)
  end

  def share_tweet
    case @social_media
    when 'slack'
      to_slack
    else
      print "#{@tweet.text}\n"
    end
  end

  def check_tweet(text, pattern, filter = '^(RT @|@)')
    text.match(/#{pattern}/i) && text.match(filter).nil? ? true : false
  end

  def streaming(account, pattern)
    puts "Reading tweets from #{account}"
    @client.filter(follow: account) do |tweet|
      if tweet.user.id == account.to_i && check_tweet(tweet.text, pattern)
        @tweet = tweet
        share_tweet
      end
    end
  rescue JSON::ParserError => e
    print e.message
    sleep 40
    retry
  rescue Twitter::Streaming::DeletedTweet => e
    p e.message
    sleep 40
    retry
  rescue Twitter::Error::TooManyRequests => e
    sleep e.rate_limit.reset_in + 1
    retry
  # This one is because there are many unknown errors
  rescue StandardError => e
    print "WARN: #{e.message}\n"
    retry
  end
end
