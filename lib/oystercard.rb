require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :money, :entry_station, :exit_station, :journey
  LIMIT = 90.00
  MINIMUM_BALANCE = 1.00
  def initialize
    @money = 0
    @journey = nil
  end

  def top_up(amount)
    fail "The limit is 90" if money + amount > LIMIT
    @money += amount
  end

  def touch_in(station)
    fail "Below Minimum Balance!" if money < MINIMUM_BALANCE
    deduct if @journey != nil
    @journey = Journey.new
    journey.entry(station)

  end

  def touch_out(exit_station)
    @journey ||= Journey.new
    @journey.exit(exit_station)
    deduct
    @journey = nil
  end



  private

  def deduct
    @money -= @journey.fare
  end

end
