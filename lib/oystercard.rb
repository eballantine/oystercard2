require_relative 'journey'

class Oystercard
  
  INITIAL_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journey
  attr_accessor :journey_history

  def initialize
    @balance = INITIAL_BALANCE
    @journey = Journey.new
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum top up (£#{TOP_UP_LIMIT}) exceeded" if exceed_top_up?(amount,balance)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_FARE
    if @journey.entry_station != nil
      @journey_history << @journey.journey 
      @balance -= PENALTY_FARE
    end
    reset_journey
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.exit_station != nil ? deduct(PENALTY_FARE) : deduct(MINIMUM_FARE)
    @journey_history << @journey.journey
    reset_journey
    @journey.finish_journey(station)
  end

  def check_journey?
    @journey.in_journey?
  end

  private

  def reset_journey
    @journey = Journey.new
  end

  def exceed_top_up?(amount, balance)
    (balance += amount) > TOP_UP_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
