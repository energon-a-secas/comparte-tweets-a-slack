require 'yaml'

module Credentials
  def load_credentials
    file = "#{Dir.pwd}/config/conf.yml"
    data = YAML.load_file(file)

    @slack_token = data['slack']['token']['test']
    @twitter_tokens = {
        consumer_key: data['twitter']['token']['consumer_key'],
        consumer_secret: data['twitter']['token']['consumer_secret'],
        access_token: data['twitter']['token']['access_token'],
        access_token_secret: data['twitter']['token']['access_token_secret']
    }
    @accounts = data['twitter']['config']['follow']
  end
end