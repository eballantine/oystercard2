class Journey
  attr_reader :journey

  def initialize
    @journey = []
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
end
