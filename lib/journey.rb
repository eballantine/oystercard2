class Journey
  attr_reader :status

  def initialize
    @status = {
      entry_station: "None recorded", 
      exit_station: "None recorded" 
    }
  end

  def start_journey(station)
    @status[:entry_station] = station
  end

  def finish_journey(station)
    # @journey_history << @status if forgot_to_tap_in?
    @status[:exit_station] = station
  end

  def in_journey?
    @status[:entry_station] != "None recorded"
  end

  def forgot_to_tap_out?
    @status[:exit_station] == "None recorded" && @status[:entry_station] != "None recorded"
  end
end
