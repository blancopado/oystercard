require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station, :history, :fare
  MINIMUM_FARE = 1.00
  PENALTY_FARE = 6.00

  def initialize
    @entry_station = nil
    @exit_station = nil
    @history = []
    @fare = PENALTY_FARE
  end

  def entry(station)
    @entry_station = station

  end

  def exit(exit_station)
    @exit_station = exit_station
    @history << {entry_station: entry_station, exit_station: exit_station}
    @fare = MINIMUM_FARE if @entry_station != nil
    @entry_station = nil
  end

  def state?
    @entry_station != nil
  end
end