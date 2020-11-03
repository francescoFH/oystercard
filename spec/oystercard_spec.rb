require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topped_up_oyster) { described_class.new(10) }
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

 describe "#touch_in" do
   it "is in a journey if the user touches into a station" do
     topped_up_oyster.touch_in
     expect(topped_up_oyster).to be_in_journey
    end

   it "raises an error when touch in if balance is less than £1" do
     minimum_balance = Oystercard::MINIMUM_BALANCE
     oystercard.balance < minimum_balance
     expect{ oystercard.touch_in }.to raise_error "Your balance is less than £#{minimum_balance}. Please top up."
    end
  end

  describe "#in_journey?" do
    context "when in jornuey" do
      it "is not in a journey by default" do
        expect(oystercard).not_to be_in_journey
      end
    end
  end

  it "can touch out" do
    topped_up_oyster.touch_in
    topped_up_oyster.touch_out
    expect(topped_up_oyster).not_to be_in_journey
  end
end
