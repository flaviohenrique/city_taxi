class MapCity
  attr_reader :map

  def initialize(map)
    @map = map
    @graph = MapGraph::Graph.new

    build_navigation_graph
  end

  def name
    @map.name
  end

  def time
    @map.time
  end

  def find_taxi(row, col)
    @map.taxis.where(row: row, col: col)
  end

  def find_waiting_passenger(row, col)
    @map.passengers.where(row: row, col: col).not_going
  end

  def restart
    Map.transaction do
      @map.taxis.destroy_all
      @map.passengers.destroy_all
      @map.update_attributes(time: 0)
    end
  end

  def move
    Map.transaction do
      match_taxis
      move_empty_taxis
      move_full_taxis
      move_going_taxis
      time_tick_map
    end
  end

  def time_tick_map
    @map.update_attributes(time: @map.time.next)
  end

  def move_empty_taxis
    @map.taxis.empty.each do |taxi|
      node = @graph.neighbors(find_node(taxi.row, taxi.col)).sample

      taxi.update_attributes(row: node.row, col: node.col)
    end
  end

  def move_full_taxis
    @map.taxis.full.includes(:passenger).each do |taxi|
      passenger = taxi.passenger
      taxi_node = find_node(taxi.row, taxi.col)
      destination_node = find_node(passenger.dest_row, passenger.dest_col)

      next_node = @graph.dijkstra(taxi_node, destination_node)[:path].second

      taxi.row = next_node.row
      taxi.col = next_node.col

      if next_node == destination_node
        taxi.status = :empty
        taxi.passenger.mark_for_destruction
      end

      taxi.save
    end
  end

  def move_going_taxis
    @map.taxis.going.each do |taxi|
      taxi_node = find_node(taxi.row, taxi.col)
      passenger_node = find_node(taxi.passenger.row, taxi.passenger.col)

      next_node = @graph.dijkstra(taxi_node, passenger_node)[:path].second

      taxi.row = next_node.row
      taxi.col = next_node.col

      if next_node == passenger_node
        taxi.status = :full
        taxi.passenger.status = :going
      end
      taxi.save
    end
  end

  def match_taxis
    @map.passengers.calling.each do |passenger|
      passenger_node = find_node(passenger.row, passenger.col)

      nearest_taxi = @map.taxis.empty
        .map {|taxi| taxis_distance(taxi, passenger_node) }
        .compact
        .reduce(&taxis_distance_nearest)

      link_taxi_and_passenger(nearest_taxi.last, passenger) if nearest_taxi.present?
    end
  end

  def taxis_distance_nearest
    -> (nearest, current) do
      current.first < nearest.first ? current : nearest
    end
  end

  def taxis_distance(taxi, passenger_node)
    taxi_node = find_node(taxi.row, taxi.col)

    route = @graph.dijkstra(taxi_node, passenger_node)

    [route[:distance], taxi] if route.present?
  end

  def link_taxi_and_passenger(taxi, passenger)
    passenger.status = :waiting
    taxi.status = :going

    taxi.passenger = passenger
    taxi.save && passenger.save
  end

  def find_node(row, col)
    @graph[(row * @map.cols) + col]
  end

  def detail
    @graph
  end

  def rows
    @map.rows
  end

  def cols
    @map.cols
  end

  private

  def build_navigation_graph
    (0...@map.rows).each do |row|
      (0...@map.cols).each do |col|
        blocked = @map.blocks.where(row: row, col: col).present?

        node = MapGraph::Node.new(row, col, blocked)

        @graph.push node

        if !blocked
          node_edges(@graph.size.pred, row).each{ |edge| @graph.connect_mutually(node, edge) }
        end
      end
    end
  end

  def map_size
    @map.cols * @map.rows
  end

  def node_edges(index, row)
    edges = []
    edges << index.pred if (row * @map.cols) != index && !index.zero?
    edges << index - @map.cols if index >= @map.cols

    edges.map{ |edge| @graph[edge] }.select{ |node| !node.blocked }
  end

end
