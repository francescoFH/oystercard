class Journey

  PENALTY_FARE = 6
  attr_accessor :enter_station, :exit_station
  def initialize
    @enter_station = nil
    @exit_station = nil
  end

  def fare
    @enter_station.nil? || @exit_station.nil? ? Journey::PENALTY_FARE : Oystercard::FARE
  end
end
