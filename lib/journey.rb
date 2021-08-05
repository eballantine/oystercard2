class Journey
  attr_reader :entry_station, :exit_station, :journey

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @journey = []
  end

  def start_journey(s)
    @journey << { :start => s }
  end

  def finish_journey(f)
    @journey.empty? ? @journey << { start: nil, fin: f } : @journey.last[:fin] = f
  end
  # complete a journey

end