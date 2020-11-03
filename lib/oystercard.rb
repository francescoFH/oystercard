class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  FARE = 1
  attr_reader :balance, :enter_station

  def initialize(balance = 0)
    @balance = balance
    @enter_station = nil
  end

  def top_up(money)
    fail "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if balance_exceeded?(money)
    update_balance(money)
  end

  def in_journey?
    @enter_station ? true : false
  end

  def touch_in(station)
    fail "Your balance is less than £#{MINIMUM_BALANCE}. Please top up." if @balance < MINIMUM_BALANCE
    @enter_station = station
  end

  def touch_out
    deduct(FARE)
    @enter_station = nil
  end

end

private

def balance_exceeded?(money)
  money + @balance > Oystercard::MAXIMUM_BALANCE
end

def update_balance(money)
  @balance += money
end

def deduct(money)
  @balance -= money
end
