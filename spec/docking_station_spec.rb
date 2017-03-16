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
    end

    it { is_expected.to respond_to(:dock).with(1).argument }

    it { is_expected.to respond_to(:bikes)}

    describe '#dock' do
      it 'docks a bike' do
        bike = Bike.new
        expect(subject.dock(bike)).to eq [bike]
      end
      it 'raises an error if the dock is filled' do
        DockingStation::DEFAULT_CAPACITY.times {subject.dock(Bike.new)}
        expect {subject.dock Bike.new}.to raise_error("Sorry, dock filled.")
      end
    end

    it 'returns docked bikes' do
      bike = Bike.new
      subject.dock(bike)
      expect(subject.bikes).to eq [bike]
    end



end
