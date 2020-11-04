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

end
