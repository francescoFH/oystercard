class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  FARE = 1
  attr_reader :balance, :enter_station, :journey_history

  def initialize(balance = 0)
    @balance = balance
    @enter_station = nil
    @journey_history = []
  end

  def top_up(money)
    fail "Maximum balance if £#{MAXIMUM_BALANCE} exceeded" if balance_exceeded?(money)
    update_balance(money)
  end

  def in_journey?
    !!@enter_station ##-> this is forced into a boolean context (true), and then negated (false), and then negated again (true)
  end

  def touch_in(station)
    fail "Your balance is less than £#{MINIMUM_BALANCE}. Please top up." if @balance < MINIMUM_BALANCE
    store_entry_station(station)
  end

  def touch_out(station)
    deduct(FARE)
    store_exit_station(station)
  end
end

private

def balance_exceeded?(money)
  money + @balance > Oystercard::MAXIMUM_BALANCE
end

def update_balance(money)
  @balance += money
end

def store_entry_station(station)
  @enter_station = station
  @journey_history.push(Journey.new)
  @journey_history.last.enter_station = station
end

def deduct(money)
  @balance -= money
end

def store_exit_station(station)
  @journey_history.last.exit_station = station
  @enter_station = nil
end
