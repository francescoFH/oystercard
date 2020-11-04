require "oystercard"

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:topped_up_oyster) { described_class.new(10) }
  let(:station) { double :station }

  context "defaults" do
    it "has a default balance of £0" do
      expect(oystercard.balance).to eq 0
    end

    it "has a default of no journey_history on new oyster card" do
      expect(oystercard.journey_history).to eq([])
    end
  end

  describe "#top_up" do
    context "when added money" do
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

  describe "#in_journey?" do
    context "default" do
      it "has a default of not being into a station" do
        expect(oystercard).not_to be_in_journey
      end
    end
  end

  describe "#touch_in" do
    context "when in journey" do
      before do
        topped_up_oyster.touch_in(station)
      end
      it "is into a station" do
        expect(topped_up_oyster).to be_in_journey
      end

      it "store entry station in journey_history" do
        expect(topped_up_oyster.journey_history[0].enter_station).to eq(station)
      end
    end

    context "when not in journey" do
      it "raises an error if balance is less than £1" do
        minimum_balance = Oystercard::MINIMUM_BALANCE
        oystercard.balance < minimum_balance
        expect{ oystercard.touch_in(station) }.to raise_error "Your balance is less than £#{minimum_balance}. Please top up."
      end

    end
  end

  describe "#touch_out" do
    context "when not in journey" do
      before do
        topped_up_oyster.touch_in(station)
        topped_up_oyster.touch_out(station)
      end
      it "can touch out" do
        expect(topped_up_oyster).not_to be_in_journey
      end

      it "deducts £1 when user touches out" do
        expect { topped_up_oyster.touch_out(station) }.to change{ topped_up_oyster.balance }.by(-Oystercard::FARE)
      end

      it "stores an exit station when touch out in journey_history" do
         expect(topped_up_oyster.journey_history[0].exit_station).to eq(station)
      end
    end
  end
end
