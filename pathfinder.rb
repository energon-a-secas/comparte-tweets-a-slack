require './social/core_twitter'
require './credentials'

# Multi thread following
class Pathfinder < Credentials
  def initialize
    @accounts = twitter_follow
  end

  # I just wanna use multiple faces
  def send_notification(text = '?', image = 'https://i.imgur.com/gadkLJn.png', channel = 'hq-development-logs')
    slack = CoreSlack.new
    slack.send_channel_message(text, channel, image)
  end

  def follow
    send_notification('Zipline deployed', 'https://i.imgur.com/ABKU5iv.png')
    threads = []
    @accounts.each do |account, f|
      filter = f[0] || '(.*)'
      threads << Thread.new do
        t = CoreTwitter.new
        t.streaming(account, filter)
      end
    end
    threads.each(&:join)
  rescue SignalException => e
    p e.message
    send_notification('Bye', 'https://i.imgur.com/FY34y2i.png')
  end
end

Pathfinder.new.follow
