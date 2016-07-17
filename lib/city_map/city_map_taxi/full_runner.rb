class CityMap::CityMapTaxi
  class FullRunner < Runner
    def run_on(navigator)
      next_node, dest_node = navigator.taxi_destination_next_node(@taxi)

      move_taxi_to_destination(@taxi, next_node, dest_node)
    end

    private

    def move_taxi_to_destination(taxi, next_node, dest_node)
      taxi.position = next_node.position

      if next_node == dest_node
        taxi.status = :empty
        taxi.remove_passenger
      end
    end
  end
end
