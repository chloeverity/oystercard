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
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      expect { subject.top_up 1 }.to raise_error "Limit exceeded"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'should deduct money from balance' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    end
    it 'shoulc deduct a minimum charge when you touch out' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
  end
  describe '#in_journey?' do
    it 'should show oyster card as not in journey when initialized' do
      oystercard = Oystercard.new
      expect(oystercard).not_to be_in_journey
    end

    it 'can touch out' do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
       expect(subject).not_to be_in_journey
    end
  end
  describe 'touch_in' do
    it 'can touch in' do
      subject.top_up(5)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it 'prevents touching in if funds insufficient' do
    oystercard = Oystercard.new
    expect { oystercard.touch_in }.to raise_error "Not enough money"
    end
  end
end
