class CityMap
  attr_accessor :map

  def initialize(map, navigator, taxis, passengers)
    @map = map
    @navigator = navigator
    @taxis = taxis
    @passengers = passengers
  end

  def id
    @map.id
  end

  def name
    @map.name
  end

  def time
    @map.time
  end

  def rows
    @map.rows
  end

  def cols
    @map.cols
  end

  def [](row, col)
    @navigator.grid[row, col]
  end

  def find_taxi(position)
    @taxis.select{ |taxi| taxi.on(position) }
  end

  def find_waiting_passenger(position)
    @passengers.select{ |passenger| passenger.waiting_on(position) }
  end

  def move
    Map.transaction do
      @passengers.each { |passenger| passenger.call_taxi(@taxis) }
      @taxis.each { |taxi| taxi.run }
      time_tick_map
    end
  end

  def restart
    Map.transaction do
      @map.taxis.destroy_all
      @map.passengers.destroy_all
      @map.update_attributes(time: 0)
      @taxis = []
      @passengers = []
    end
  end

  def time_tick_map
    @map.update_attributes(time: @map.time.next)
  end

end
