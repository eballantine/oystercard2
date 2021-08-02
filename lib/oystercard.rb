class Oystercard
  
  INITIAL_BALANCE = 0
  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize 
    @balance = INITIAL_BALANCE
    @in_use = false
  end

  def top_up(amount)
    raise "Maximum top up (£#{TOP_UP_LIMIT}) exceeded" if exceed_top_up?(amount,balance)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def exceed_top_up?(amount, balance)
    (balance += amount) > TOP_UP_LIMIT
  end

end