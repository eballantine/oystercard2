class Oystercard
  
  INITIAL_BALANCE = 0
  TOP_UP_LIMIT = 90
  attr_reader :balance

  def initialize 
    @balance = INITIAL_BALANCE
  end

  def top_up(amount)
    raise "Maximum top up (£#{TOP_UP_LIMIT}) exceeded" if exceed_top_up?(amount,balance)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def exceed_top_up?(amount, balance)
    (balance += amount) > TOP_UP_LIMIT
  end

end