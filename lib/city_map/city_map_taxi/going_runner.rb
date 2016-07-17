class CityMap::CityMapTaxi
  class GoingRunner < Runner
    def run_on(navigator)
      next_node, passenger_node = navigator.taxi_passenger_next_node(@taxi)

      move_taxi_to_passenger(@taxi, next_node, passenger_node)
    end

    private

    def move_taxi_to_passenger(taxi, next_node, passenger_node)
      taxi.position = next_node.position

      if next_node == passenger_node
        taxi.status = :full
        taxi.passenger.status = :going
      end
    end
  end
end
