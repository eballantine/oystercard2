class Oystercard
  
  INITIAL_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :current_journey
  attr_accessor :journey_history

  def initialize
    @balance = INITIAL_BALANCE
    @journey_history = []
    @current_journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum top up (£#{TOP_UP_LIMIT}) exceeded" if exceed_top_up?(amount,balance)
    
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_FARE

    failed_to_tap_out if @current_journey.forgot_to_tap_out?
    current_journey.start_journey(station)
  end

  def touch_out(station)
    @current_journey.finish_journey(station)
    deduct(fare)
    @journey_history << @current_journey.status
    @current_journey = Journey.new
  end

  def check_journey?
    @current_journey.in_journey?
  end

  private

  def exceed_top_up?(amount, balance)
    (balance += amount) > TOP_UP_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

  def fare
    if @current_journey.status[:exit_station] != "None recorded" && @current_journey.status[:entry_station] == "None recorded"
      PENALTY_FARE
    else 
      MINIMUM_FARE 
    end
  end

  def failed_to_tap_out 
    deduct(PENALTY_FARE)
    @journey_history << @current_journey.status 
    @current_journey = Journey.new
  end
end
