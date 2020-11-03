require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it "returns balance of £0 by default" do
    expect(oystercard.balance).to eq 0
  end

  describe "#top_up" do
    context "When added money" do
      it "returns balance of £10" do
        expect{ oystercard.top_up(10) }.to change{ oystercard.balance }.by(10)
      end

      it "raises an error if takes balance over £90" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        oystercard.top_up(maximum_balance)
        expect{ oystercard.top_up(1) }.to raise_error "Maximum balance if £#{maximum_balance} exceeded"
      end
    end
  end

  describe "#deduct" do
    context "When deduct money" do
      it "reduces balance by £5" do
        expect{ oystercard.deduct(5) }.to change{ oystercard.balance }.by(-5)
      end
    end
  end

  it "is not in a journey by default" do
    expect(oystercard).not_to be_in_journey
  end

  it "is in a journey if the user touches into a station" do
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end

  it "can touch out" do
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard).not_to be_in_journey
  end 

end
