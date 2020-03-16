require 'yaml'

class Credentials
  def load(file = 'conf.yml')
    YAML.load_file("#{Dir.pwd}/config/#{file}")
  rescue Errno::ENOENT => e
    p e.message
    exit
  end

  def slack_set_config
    credentials = load
    @bot_token = credentials['slack']['tokens']['prod']
    @bot_name = credentials['slack']['config']['name']
    @bot_icon = credentials['slack']['config']['icon']
    @bot_channel = credentials['slack']['config']['channel']
  end

  def slack_users
    credentials = load
    credentials['slack']['users']
  end

  def twitter_token
    credentials = load
    twitter = credentials['twitter']['config']['tokens']
    { consumer_key: twitter['consumer_key'],
      consumer_secret: twitter['consumer_secret'],
      access_token: twitter['access_token'],
      access_token_secret: twitter['access_token_secret'] }
  end

  def twitter_follow
    credentials = load
    credentials['twitter']['config']['accounts']
  end
end
