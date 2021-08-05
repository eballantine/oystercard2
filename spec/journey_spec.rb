require 'journey'

describe Journey do
  let(:oystercard) { instance_double('oystercard') }
  context "#initialize" do
    it "can record a journey" do
      expect(subject).to have_attributes(:journey => [])
    end
    
    it "should record entry station in journey" do
      subject.start_journey('Mayfair')
      expect(subject.journey).to eq([{:start => 'Mayfair'}])
    end

    it "should record exit station in journey" do
      subject.start_journey('Mayfair')
      subject.finish_journey('Chiswick')
      expect(subject.journey).to eq([{:start => 'Mayfair', :fin => 'Chiswick'}])
    end

    it "should record a journey when only given an exit station" do
      subject.finish_journey('Green Park')
      expect(subject.journey).to eq([{:start => nil, :fin => 'Green Park'}])
    end

    context "customer forgets to tap out" do
      it "should record a journey to oystercard with only an entry station" do
        subject.start_journey('Mayfair')
        subject.start_journey('Borough')
        expect(oystercard.journey_history.last).to eq({:start => 'Mayfair', :fin => nil})
      end

      it "should record entry station in journey" do
        allow(oystercard).to receive(:journey_history).and_return([])
        subject.start_journey('Mayfair')
        subject.start_journey('Borough')
        expect(subject.journey).to eq [{:start => 'Borough'}]
      end
    end
  end
end
