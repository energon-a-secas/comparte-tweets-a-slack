require 'yaml'

class Credentials

  def load(file = 'conf.yml')
    YAML.load_file("#{Dir.pwd}/config/#{file}")
  end

  def slack_token
    credentials = load
    credentials['slack']['token']['test']
  end

  def twitter_token
    credentials = load
    twitter = credentials['twitter']['token']
    { consumer_key: twitter['consumer_key'],
      consumer_secret: twitter['consumer_secret'],
      access_token: twitter['access_token'],
      access_token_secret: twitter['access_token_secret'] }
  end

  def twitter_account
    credentials = load
    credentials['twitter']['config']['follow']
  end
end
