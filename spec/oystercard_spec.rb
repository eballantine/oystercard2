require 'oystercard'

describe Oystercard do

	it "gives an initial balance of 0" do
  	expect(subject.balance).to eq 0
	end

	it "tops up the balance on the card" do
    expect { subject.top_up(10)}.to change { subject.balance }.from(0).to(10)

	end

end
