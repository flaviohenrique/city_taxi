class CityMap
  delegate  :id,
            :name,
            :time,
            :rows,
            :cols,
            :persisted?,
            :model_name, to: :@map

  def initialize(map, navigator, taxis, passengers)
    @map = map
    @navigator = navigator
    @taxis = taxis
    @passengers = passengers
  end

  def area
    grid = @navigator.grid.to_a

    grid.each_index do |row_index|
      grid[row_index].each_index do |col_index|
        node = grid[row_index][col_index]
        grid[row_index][col_index] = CityMapNode.new(
          row_index,
          col_index,
          node.blocked?,
          find_passenger(Position.new(row_index, col_index)),
          find_taxi(Position.new(row_index, col_index))
        )
      end
    end
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

  def find_passenger(position)
    @passengers.select{ |passenger| passenger.on(position) }
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
      @map.passengers.destroy_all
      @map.taxis.destroy_all
      @map.update_attributes(time: 0)
      @taxis = []
      @passengers = []
    end
  end

  def time_tick_map
    @map.update_attributes(time: @map.time.next)
  end

end
