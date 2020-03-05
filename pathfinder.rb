require './core_twitter.rb'
require './credentials'

class Pathfinder < Credentials
  def self.twitter
    threads = []
    twitter_account.each do |a, d|
      threads << Thread.new do
        deals = CoreTwitter.new
        deals.streaming(a, d)
      end
    end
    threads.each(&:join)
  end
end

Pathfinder.twitter
