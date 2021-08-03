class Oystercard
  
  INITIAL_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station

  def initialize 
    @balance = INITIAL_BALANCE
    @entry_station
  end

  def top_up(amount)
    raise "Maximum top up (£#{TOP_UP_LIMIT}) exceeded" if exceed_top_up?(amount,balance)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def exceed_top_up?(amount, balance)
    (balance += amount) > TOP_UP_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
