require 'oystercard'

describe Oystercard do
  let(:station) { double('station') }

  describe '#initialize' do

	  it "gives an initial balance of 0" do
    	expect(subject.balance).to eq 0
	  end
  end

  describe '#top_up' do

  	it "tops up the balance on the card" do
      expect { subject.top_up(10) }.to change { subject.balance }.from(0).to(10)
	  end

    it "raises an error if user tries to top up above £90" do
      top_up_limit = Oystercard::TOP_UP_LIMIT
      error_message = "Maximum top up (£#{top_up_limit}) exceeded"
      expect { subject.top_up(top_up_limit+1) }.to raise_error error_message
    end
  end

  context "When topped up by £10" do

    before do
      subject.top_up(10)
    end

	  describe '#deduct' do
      it "deducts the fare from the card" do
        expect { subject.send(:deduct, 10) }.to change { subject.balance }.from(10).to(0)
      end
    end

    describe '#touch_in' do
      it "raises an error if card balance less than minimum amount" do
        subject = described_class.new
        expect{ subject.touch_in(station) }.to raise_error "Insufficient funds"
      end

      it "starts a new journey" do
        expect(subject).to respond_to(:touch_in)
      end

      context "last journey failed to touch out" do
        before do 
          subject.touch_in("Oxford Street")
        end

        it "deducts a penalty fare" do
          expect{ subject.touch_in("Chiswick Park") }.to change { subject.balance }.by(-(Oystercard::PENALTY_FARE))
        end

        it "should record the last journey" do
          subject.touch_in("Chiswick Park")
          expect(subject.journey_history.last).to eq({:entry_station => "Oxford Street", :exit_station => "None recorded"})
        end
      end
    end

    describe '#touch_out' do
      it "deducts the minimum fare when touched out" do
        subject.touch_in(station)
        expect { subject.touch_out(station) }.to change { subject.balance }.by(-(Oystercard::MINIMUM_FARE))
      end

      it "stores a completed journey" do
        subject.touch_in(station)
        expect { subject.touch_out(station) }.to change { subject.journey_history.length }.by(1) 
      end

      context "user didn't touch in" do
        it "deducts the penalty fare" do
          subject.touch_out("Borough")
          expect{ subject.touch_out("Chiswick Park") }.to change { subject.balance }.by(-(Oystercard::PENALTY_FARE))
        end
      end
    end

    describe '#check_journey?' do
      context "not tapped in" do
        it "should confirm card is not in use" do
          expect(subject.check_journey?).to be false
        end
      end
      context "tapped in, not yet tapped out" do
        it "should confirm the card is in use" do
          expect { subject.touch_in(station) }.to change { subject.check_journey? }.from(false).to(true)
        end
      end
    end
  end
end
