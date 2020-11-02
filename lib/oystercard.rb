class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    fail "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if balance_exceeded?(money)
    update_balance(money)
  end

  def deduct(money)
    @balance -= money
  end

end

private

def balance_exceeded?(money)
  money + @balance > Oystercard::MAXIMUM_BALANCE
end

def update_balance(money)
  @balance += money
end
