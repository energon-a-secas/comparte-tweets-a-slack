require './social/core_twitter.rb'

class Pathfinder
  def self.twitter
    threads = []
    ['73459349', '1187606581363531776'].each do |v|
      threads << Thread.new do
        deals = CoreTwitter.new
        deals.streaming(v)
      end
    end
    threads.each(&:join)
  end
end

Pathfinder.twitter
