require './social/core_twitter'

describe CoreTwitter do
  describe '#validate' do
    let(:text_1) { 'problemas con el metro' }
    let(:text_2) { 'PROBLEMAS con el METRO' }
    let(:text_3) { 'disturbios la estación' }
    let(:text_3) { 'Sin detención en la estacion' }
    let(:fake_text_1) { 'Disfrutemos de un lindo día' }
    let(:fake_text_2) { 'Disfrutemos de un lindo día en el metró' }
    let(:fake_type_1) { 'RT @fakeuser Disfrutemos de un lindo día en el metro' }
    let(:fake_type_2) { '@metrodesantiago ten un lindo día' }
    let(:pattern) { '(metro|problemas|estaci[oó])' }
    let(:filter) { '^(RT @|@)' } # Negates retweets or mentions.
    let(:twitter) { described_class.new }

    context 'when tweet match' do
      it { expect(twitter.validate(text_1, pattern, filter)).to be true }
      it { expect(twitter.validate(text_2, pattern, filter)).to be true }
      it { expect(twitter.validate(text_3, pattern, filter)).to be true }
    end

    context 'when tweet text doesnt match' do
      it { expect(twitter.validate(fake_text_1, pattern, filter)).to be false }
      it { expect(twitter.validate(fake_text_2, pattern, filter)).to be false }
    end

    context 'when tweet type doesnt match' do
      it { expect(twitter.validate(fake_type_1, pattern, filter)).to be false }
      it { expect(twitter.validate(fake_type_2, pattern, filter)).to be false }
    end
  end
end
