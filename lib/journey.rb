require_relative 'oystercard'

class Journey
  attr_reader :journey, :entry_station, :exit_station

  def initialize
    @journey = []
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(s)
    save_to_card unless @journey.empty? 
    @journey = [{ start: s }]
  end

  def finish_journey(f)
    @journey.empty? ? @journey << { start: nil, fin: f } : @journey.last[:fin] = f
  end

  def save_to_card(card)
    card.journey_history << @journey
  end

  def in_journey?
    @entry_station != nil
  end
end
