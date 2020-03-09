require './social/core_twitter'
require './credentials'

# Multi thread following
class Pathfinder < Credentials
  def initialize
    @accounts = twitter_follow
  end

  def self.twitter
    threads = []
    @accounts.each do |account, _p|
      threads << Thread.new do
        t = CoreTwitter.new
        t.streaming(account)
      end
    end
    threads.each(&:join)
  rescue SignalException => e
    p e
  end
end

Pathfinder.new
