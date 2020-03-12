require_relative '../spec_helper'

described_class CoreSlack do
  before(:all) do
    @slack = CoreSlack.new
  end

  context 'when get id succeeds' do
    it { expect(@slack.direct_message_id('j')).equal?(Hash) }
  end

  context 'when get id fails' do
    it { expect(@slack.direct_message_id('FAKEID123')).to be false }
  end
end

describe '#send_to_channel' do
  context 'when post succeeds' do
    it { expect(CoreSlack.new.send_channel_message('RTest', 'hq-enerlogs').ok).to be true }
    it { expect(CoreSlack.new.send_channel_message('RTest', 'hq-enerlogs').message.text).to eql 'RTest' }
  end

  context 'when post fails' do
    it { expect(CoreSlack.new.send_channel_message('RTest', 'fake channel')).to be false }
  end
end
