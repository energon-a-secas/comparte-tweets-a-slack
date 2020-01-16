require 'twitter'
require './config/yaml_config'
require './social/web_slack'

class Finder
  include WebSlack
  include Credentials

  def initialize
    load_credentials

    threads = []
    @accounts.each do |account, v|
      threads << Thread.new do
        client = Twitter::Streaming::Client.new(@twitter_tokens)
        p "Reading tuits from #{account}"
        client.filter(follow: v[0]) do |tweet|
          if tweet.is_a?(Twitter::Tweet) && !tweet.text.include?((v[2]).to_s)
            send_to_channel(@slack_token, tweet.uri)
          end
        end
      end
    end
    threads.each(&:join)
  end
end

begin
  Finder.new
rescue
  sleep(800)
  retry
end