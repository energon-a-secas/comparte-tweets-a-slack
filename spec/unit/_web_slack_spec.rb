require_relative '../spec_helper'
require './social/web_slack'

file = "#{Dir.pwd}/conf.yml"
data = YAML.load_file(file)

describe '#persa' do
  context 'when post succeed' do
    before(:each) do
      @dummy_class = DummyClass.new
      @dummy_class.extend(WebSlack)
    end

    it { expect(@dummy_class.send_to_channel(data['slack']['token']['test'], 'test').to(be_a_kind_of(Array))) }
  end
end