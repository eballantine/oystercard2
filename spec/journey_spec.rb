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
    
    it "should record entry station in journey" do
      subject.start_journey('Mayfair')
      expect(subject.journey).to eq([{:start => 'Mayfair'}])
    end

    it "should record exit station in journey" do
      subject.start_journey('Mayfair')
      subject.finish_journey('Chiswick')
      expect(subject.journey).to eq([{:start => 'Mayfair', :finish => 'Chiswick'}])
    end

    it "should record a journey when only given an exit station" do
      subject.finish_journey('Green Park')
      expect(subject.journey).to eq([{:start => nil, :finish => 'Green Park'}])
    end

    it "should record a journey when only given an entry station" do
      
    end

  end

end