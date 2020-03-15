require './social/core_slack'

describe CoreSlack do
  describe '#send_to_channel' do
    let(:text) { 'RTest' }
    let(:test_channel) { 'hq-development-logs' }
    let(:fake_channel) { 'fake channel' }
    let(:slack) { described_class.new }

    context 'when post succeeds' do
      it { expect(slack.send_channel_message(text, test_channel).ok).to be true }
      it { expect(slack.send_channel_message(text, test_channel).message.text).to eql text }
    end

    context 'when post fails' do
      it { expect(slack.send_channel_message(text, fake_channel)).to be false }
    end
  end

  describe '#direct_message_id' do
    let(:test_id) { 'j' }
    let(:fake_id) { 'FAKEID123' }
    let(:slack) { described_class.new }

    context 'when get id succeeds' do
      it { expect(slack.direct_message_id(test_id)).equal?(Hash) }
    end

    context 'when get id fails' do
      it { expect(slack.direct_message_id(fake_id)).to be false }
    end
  end

  describe '#user_content' do
    let(:text) { 'Did you ever hear the Tragedy of Darth Plagueis the wise?' }
    let(:ok_filter) { 'of' }
    let(:good_filter) { 'Plagueis' }
    let(:bad_filter) { 'Obi wan' }
    let(:slack) { described_class.new }

    context 'when match succeeds' do
      it { expect(slack.user_content(text, ok_filter)).equal?(Array) }
      it { expect(slack.user_content(text, good_filter)).equal?(Array) }
    end

    context 'when match fails' do
      it { expect(slack.user_content(text, bad_filter)).to be nil }
    end
  end
end
