require 'journey'

describe Journey do
  context "#initialize" do
    it "can record an entry station" do
      expect(subject).to have_attributes(:entry_station => nil)
    end

    it "can record an exit station" do
      expect(subject).to have_attributes(:exit_station => nil)
    end

    it "can record a journey" do
      expect(subject).to have_attributes(:journey => [])
    end
    
    it "should record a journey when only given an exit station" do
      test_journey = described_class.new(exit_station: "Kings Cross")
      expect(test_journey.journey).to eq [entry_station: nil, exit_station: "Kings Cross"]
    end

    it "should record a journey when given an entry and exit station" do
      
    end
  end

end