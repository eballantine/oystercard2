class Oystercard
  
  INITIAL_BALANCE = 0
  attr_reader :balance

  def initialize 
    @balance = INITIAL_BALANCE
  end

  def top_up(amount)
    @balance += amount
  end
end