class CityMap
  attr_accessor :layers

  def initialize(map, layers)
    @map = map
    @layers = layers
  end

  def match_taxis
    @map.passengers.calling.each do |passenger|
      taxi = @layers.nearest_taxi(passenger , @map.taxis.empty)

      link_taxi_and_passenger(nearest_taxi, passenger)
    end
  end

  def move_full_taxis
    @map.taxis.full.includes(:passenger).each do |taxi|
      next_node, dest_node = taxi_next_node(taxi)
    end
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

  def link_taxi_and_passenger(taxi, passenger)
    passenger.status = :waiting
    taxi.status = :going

    taxi.passenger = passenger
    taxi.save && passenger.save
  end
end
