require "docking_station"

describe DockingStation do
    it { is_expected.to respond_to :release_bike }
    it "releases a bike when release_bike is called" do
      bike = subject.release_bike
      expect(bike).to be_working
    end
end
