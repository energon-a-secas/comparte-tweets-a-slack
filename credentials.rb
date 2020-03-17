require 'yaml'

class Credentials
  def load(file = 'conf.yml')
    YAML.load_file("#{Dir.pwd}/config/#{file}")
  rescue Errno::ENOENT => e
    default_file = 'conf.yml.example'
    p "#{e.message}. Using #{default_file}"
    load(default_file)
  end

  def slack_set_config
    credentials = load
    @bot_token = credentials['slack']['tokens']['prod'] || ENV['SLACK_TOKENS_PROD']
    @bot_name = credentials['slack']['config']['name'] || ENV['SLACK_C_NAME']
    @bot_icon = credentials['slack']['config']['icon'] || ENV['SLACK_C_ICON']
    @bot_channel = credentials['slack']['config']['channel'] || ENV['SLACK_C_CHANNEL']
  end

  def slack_users
    credentials = load
    credentials['slack']['users'] || ENV['SLACK_USERS'][0]
  end

  def twitter_token
    credentials = load
    twitter = credentials['twitter']['config']['tokens']
    { consumer_key: twitter['consumer_key'] || ENV['TWITTER_CT_CONSUMER_KEY'],
      consumer_secret: twitter['consumer_secret'] || ENV['TWITTER_CT_CONSUMER_SECRET'],
      access_token: twitter['access_token'] || ENV['TWITTER_CT_ACCESS_TOKEN'],
      access_token_secret: twitter['access_token_secret'] || ENV['TWITTER_CT_ACCESS_SECRET'] }
  end

  def twitter_follow
    credentials = load
    credentials['twitter']['config']['accounts'] || ENV['TWITTER_C_ACCOUNTS'].split(' ')
  end
end
