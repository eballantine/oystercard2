require 'oystercard'

describe Oystercard do

  describe '#balance' do

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

    before(:each) do
      subject.top_up(10)
    end
	  describe '#deduct' do
		
      it "deducts the fare from the card" do
        expect { subject.send(:deduct, 10) }.to change { subject.balance }.from(10).to(0)
      end
    
    end

    describe '#touch_in' do
      
      it "changes @in_use to true when touched in" do
        expect { subject.touch_in }.to change { subject.in_journey? }.from(false).to(true)
      end

      it "raises an error if card balance less than minimum amount" do
        subject = described_class.new
        expect { subject.touch_in }.to raise_error "Insufficient funds"
      end

    end

    describe '#touch_out' do

      it "changes @in_use to be false when touched out" do
        subject.touch_in
        expect { subject.touch_out }.to change { subject.in_journey? }.from(true).to(false)
      end

      it "deducts the minimum fare when touched out" do
        subject.touch_in
        expect { subject.touch_out }.to change { subject.balance }.by(-(Oystercard::MINIMUM_FARE))
      end

    end

    describe '#in_journey?' do
    
      it "checks to see if the card is being used when user hasn't touched in" do
        expect(subject.in_journey?).to be false
      end

      it "checks to see if the card being used when user has touched in" do
        expect { subject.touch_in }.to change { subject.in_journey? }.from(false).to(true)
      end

    end
  end

end
