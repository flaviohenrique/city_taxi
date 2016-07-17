class CityMap::Navigator
  attr_reader :grid

  def initialize(grid, graph)
    @grid       = grid
    @graph      = graph
  end

  def nearest_taxi(passenger, taxis)
    taxis.map { |taxi| taxis_distance(taxi, passenger) }
         .compact
         .reduce { |nearest, taxi| taxis_distance_nearest(nearest, taxi) }
         .try(:last)
  end

  def taxi_neighbors(taxi)
    @graph.neighbors(find_node(taxi.position))
  end

  def taxi_destination_next_node(taxi)
    passenger = taxi.passenger
    taxi_next_node(taxi.position, passenger.dest_position)
  end

  def taxi_passenger_next_node(taxi)
    passenger = taxi.passenger
    taxi_next_node(taxi.position, passenger.position)
  end

  private

  def taxi_next_node(taxi_position, dest_position)
    taxi_node = find_node(taxi_position)
    dest_node = find_node(dest_position)

    [next_node(taxi_node, dest_node), dest_node]
  end

  def find_node(position)
    @grid[*position.to_a]
  end

  def taxis_distance_nearest(nearest, current)
    current.first < nearest.first ? current : nearest
  end

  def next_node(current_node, dest_node)
    @graph.dijkstra(current_node, dest_node)[:path].second
  end

  def taxis_distance(taxi, passenger)
    taxi_node = find_node(taxi.position)
    passenger_node = find_node(passenger.position)

    route = @graph.dijkstra(taxi_node, passenger_node)

    [route[:distance], taxi] if route.present?
  end
end
