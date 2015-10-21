require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {{ entry_station: entry_station, exit_station: exit_station }}

  describe '#initialize' do
    it 'has a default of 0' do
      expect(subject.money).to eq(0)
    end
  end

  describe '#top_up' do
    it {is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1.00 }.to change{ subject.money }.by 1.00
    end

    it 'limit is 90' do
      subject.top_up(described_class::LIMIT)
      expect{subject.top_up(1.00)}.to raise_error("The limit is 90")
    end
  end

  describe '#station' do
    it { is_expected.to respond_to(:entry_station) }

    it 'a new card has no station' do
      expect(subject.entry_station).to be nil
    end
  end

  describe '#touch_in' do

    it {is_expected.to respond_to(:touch_in).with(1).argument}

    it 'raises an error when touching in with a balance lower than minimum' do
      subject.top_up(0.99)
      expect { subject.touch_in(entry_station) }.to raise_error "Below Minimum Balance!"
    end

  end
  describe '#touch_out' do
    before(:each) do
      subject.top_up(1.00)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument}

    it 'update touch_out method to reduce the balance by minimum fare' do
      expect {subject.touch_out(exit_station)}.to change{subject.money}.by -described_class::MINIMUM_FARE
    end
  end
  describe '#fare' do
   it 'returns the minimum fare' do
      expect(subject.fare).to eq described_class::MINIMUM_FARE
   end
  end


end
