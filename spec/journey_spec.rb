require 'journey'

describe Journey do
let (:station) { double :station}

  it "is nil by default" do
    expect(subject.enter_station).to eq(nil)
  end

  it "stores the enter station" do
    subject.enter_station = station
    expect(subject.enter_station).to eq(station)
  end

  it "is nil by default" do
    expect(subject.exit_station).to eq(nil)
  end

  it "stores the enter station" do
    subject.exit_station = station
    expect(subject.exit_station).to eq(station)
  end

  it "returns default fare if end and start aren't nil" do
    subject.enter_station = station
    subject.exit_station = station
    expect(subject.fare).to eq Oystercard::FARE
  end

  it "returns penalty fare if enter or exit are nil" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
end
