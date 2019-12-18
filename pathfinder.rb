# frozen_string_literal: true

require 'twitter'
require './config/yaml_config'
require './social/web_slack'

# Just for run
class Finder
  include WebSlack
  include Credentials

  def initialize
    load_credentials

    threads = []
    @accounts.each do |account, v|
      threads << Thread.new do
        client = Twitter::Streaming::Client.new(@twitter_tokens)
        p "Reading tuits from #{account}: #{v[1]}"
        client.filter(follow: v[0]) do |tweet|
          if tweet.is_a?(Twitter::Tweet) && !tweet.text.include?((v[1]).to_s)
            send_to_channel(@slack_token, tweet.uri)
          end
        end
      end
    end
    threads.each(&:join)
  end
end

Finder.new
