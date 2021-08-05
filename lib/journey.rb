require_relative 'oystercard'

class Journey
  attr_reader :journey, :entry_station, :exit_station

  def initialize
    @journey = [{entry_station: nil, exit_station: nil}]
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(s)
    @journey.last[:entry_station] = s
    @entry_station = s
  end

  def finish_journey(f)
    @journey.last[:exit_station] = f
    @exit_station = f
  end

  def in_journey?
    @entry_station != nil
  end
end
