require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it 'shows balance of zero' do
      oystercard = Oystercard.new
      expect(subject.balance).to eq(0)
    end
  end
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'allows customer to add money to card' do
      oystercard = Oystercard.new
      #oystercard.top_up(5)
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end
    it 'raises an error if balance is over limit' do
      oystercard = Oystercard.new
      expect { subject.top_up(91) }.to raise_error "Limit exceeded"
    end
  end

end
