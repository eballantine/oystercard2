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

end
