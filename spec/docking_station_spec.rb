require "docking_station"

describe DockingStation do
    it { is_expected.to respond_to :release_bike }

    describe '#release_bike' do
      it 'releases a bike' do
        bike = Bike.new
        subject.dock(bike)
        expect(subject.release_bike).to eq bike
      end
      it 'raises an error if there are no bikes' do
        expect {subject.release_bike}.to raise_error("No bikes available")
      end
      it 'does not release broken bike' do
        bike = Bike.new
        bike.report_broken
        subject.dock(bike)
        expect{subject.release_bike}.to raise_error("Sorry, bike broken!")
      end
    end

    it { is_expected.to respond_to(:dock).with(1).argument }

    it { is_expected.to respond_to(:bikes)}

    describe '#dock' do
      it 'docks a bike' do
        bike = Bike.new
        expect(subject.dock(bike)).to eq [bike]
      end
      it 'raises an error if the dock is filled' do
        subject.capacity.times {subject.dock(Bike.new)}
        expect {subject.dock Bike.new}.to raise_error("Sorry, dock filled.")
      end
    end

    it 'returns docked bikes' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.bikes).to eq [bike]
    end

    it 'has a default capacity' do
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end

    describe 'initialization' do
      subject { DockingStation.new }
      let(:bike) { Bike.new }
      it 'defaults capacity' do
        described_class::DEFAULT_CAPACITY.times do
          subject.dock(bike)
        end
        expect { subject.dock(bike) }.to raise_error 'Sorry, dock filled.'
      end
    end

end
