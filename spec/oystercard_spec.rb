require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it 'shows balance of zero' do
      oystercard = Oystercard.new
      expect(subject.balance).to eq(0)
    end
  end

end
