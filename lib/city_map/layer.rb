class CityMap::Layer
  attr_reader :grid

  def initialize(grid, navigation)
    @grid = grid
    @navigation = navigation
  end

  def nearest_taxi(passenger, taxis)
    taxis.map { |taxi| taxis_distance(taxi, passenger) }
         .compact
         .reduce { |nearest, taxi| taxis_distance_nearest(nearest, taxi) }
         .try(:last)
  end

  def taxi_neighbors(taxi)
    @navigation.neighbors(find_node(taxi.position))
  end

  def taxi_destination_next_node(taxi)
    passenger = taxi.passenger
    taxi_node = find_node(taxi.position)
    dest_node = find_node(passenger.dest_position)

    [next_node(taxi_node, dest_node), dest_node]
  end

  def taxi_passenger_next_node(taxi)
    passenger = taxi.passenger
    taxi_node = find_node(taxi.position)
    dest_node = find_node(passenger.position)

    [next_node(taxi_node, dest_node), dest_node]
  end


  private

  def find_node(position)
    @grid[*position.to_a]
  end

  def taxis_distance_nearest(nearest, current)
    current.first < nearest.first ? current : nearest
  end



  # def find_dest_node(object)
  #   @grid[object.dest_row, object.dest_col]
  # end

  def next_node(current_node, dest_node)
    @navigation.dijkstra(current_node, dest_node)[:path].second
  end

  def taxis_distance(taxi, passenger)
    taxi_node = find_node(taxi.position)
    passenger_node = find_node(passenger.position)

    route = @navigation.dijkstra(taxi_node, passenger_node)

    [route[:distance], taxi] if route.present?
  end
end
