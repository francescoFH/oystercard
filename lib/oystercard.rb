class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance, :enter_station

  # attr_accessor :in_journey

  def initialize
    @balance = 0
    @enter_station = nil
  end

  def top_up(money)
    fail "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if balance_exceeded?(money)
    update_balance(money)
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @enter_station ? true : false
  end

  def touch_in
    @enter_station = true
  end

  def touch_out
    @enter_station = false
  end

end

private

def balance_exceeded?(money)
  money + @balance > Oystercard::MAXIMUM_BALANCE
end

def update_balance(money)
  @balance += money
end
