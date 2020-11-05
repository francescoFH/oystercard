require 'journey'

describe Journey do
let (:station) { double :station}

  describe "#initialize" do
    it "stores the enter station" do
      subject.enter_station = station
      expect(subject.enter_station).to eq(station)
    end

    it "stores the exit station" do
      subject.exit_station = station
      expect(subject.exit_station).to eq(station)
    end

    context "defaults" do
      it "has default nil for enter_station" do
        expect(subject.enter_station).to eq(nil)
      end

      it "has default nil for exit_station" do
        expect(subject.exit_station).to eq(nil)
      end
    end
  end

  describe "#fare" do
    it "returns default fare if end and start aren't nil" do
      subject.enter_station = station
      subject.exit_station = station
      expect(subject.fare).to eq Oystercard::FARE
    end

    it "returns penalty fare if enter or exit are nil" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end
