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
        user_id = v[0]
        user_name = v[1]
        content_filter = v[2]
        p "Reading tuits from #{account}: #{user_name}"
        client.filter(follow: user_id) do |tweet|
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
