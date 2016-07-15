class CityMap::Layer
  def initialize(grid, navigation)
    @grid = grid
    @navigation = navigation
  end

  taxis_distance_nearest -> (nearest, current) do
    current.first < nearest.first ? current : nearest
  end

  def nearest_taxi(passenger, taxis)
    taxis.map { |taxi| taxis_distance(taxi, passenger) }
         .compact
         .reduce(&taxis_distance_nearest)
         .try(:last)
  end

  def taxi_next_node(taxi)
    passenger = taxi.passenger
    taxi_node = find_node(taxi)
    dest_node = find_dest_node(passenger)

    next_node(taxi_node, dest_node), dest_node
  end

  # def move_full_taxis
  #   @map.taxis.full.includes(:passenger).each do |taxi|
  #     passenger = taxi.passenger
  #     taxi_node = find_node(taxi.row, taxi.col)
  #     destination_node = find_node(passenger.dest_row, passenger.dest_col)
  #
  #     next_node = @graph.dijkstra(taxi_node, destination_node)[:path].second
  #
  #     taxi.row = next_node.row
  #     taxi.col = next_node.col
  #
  #     if next_node == destination_node
  #       taxi.status = :empty
  #       taxi.passenger.mark_for_destruction
  #     end
  #
  #     taxi.save
  #   end
  # end


  private

  def find_node(node)
    @grid[node.row, node.col]
  end

  def find_dest_node(node)
    @grid[node.dest_row, node.dest_col]
  end

  def next_node(current_node, dest_node)
    @navigation.dijkstra(current_node, dest_node)[:path].second
  end

  def taxis_distance(taxi, passenger)
    taxi_node = find_node(taxi)
    passenger_node = find_node(passenger)

    route = @navigation.dijkstra(taxi_node, passenger_node)

    [route[:distance], taxi] if route.present?
  end
end
