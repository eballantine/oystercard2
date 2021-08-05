require_relative 'journey'

class Oystercard
  
  INITIAL_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance
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
    @journey_history << @journey if @journey.entry_station != nil
    @joruney
    @journey.start_journey(station)

    end
    # if it has entry but no exit
    # chech journey if exit station is not nil
    # save full journey in JH and start new one
    
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    # @exit_station = station
    # @journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
    @journey.finish_journey(station)
  end

  private

  def reset_journey
    @journey.entry_station = nil
    @journey.entry_station = nil
  end

  def exceed_top_up?(amount, balance)
    (balance += amount) > TOP_UP_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
