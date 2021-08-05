require 'journey'

describe Journey do
  let(:oystercard) { instance_double('oystercard') }
  context "#initialize" do
    it "can record a journey" do
      expect(subject).to have_attributes(:journey => [{entry_station: nil, exit_station: nil}])
    end
    
    it "should record entry station in journey" do
      subject.start_journey('Mayfair')
      expect(subject.journey).to eq([{:entry_station => 'Mayfair', :exit_station => nil}])
    end

    it "should record exit station in journey" do
      subject.start_journey('Mayfair')
      subject.finish_journey('Chiswick')
      expect(subject.journey).to eq([{:entry_station => 'Mayfair', :exit_station => 'Chiswick'}])
    end

    it "should record a journey when only given an exit station" do
      subject.finish_journey('Green Park')
      expect(subject.journey).to eq([{:entry_station => nil, :exit_station => 'Green Park'}])
    end

    context "customer forgets to tap out" do
      it "should record entry station in journey" do
        allow(oystercard).to receive(:journey_history).and_return([])
        subject.start_journey('Mayfair')
        subject.start_journey('Borough')
        expect(subject.journey).to eq [{:entry_station => 'Borough', :exit_station => nil}]
      end
    end
  end
end
