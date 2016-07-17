class CityMap::CityMapTaxi
  class EmptyRunner < Runner
    def run_on(navigator)
      node = navigator.taxi_neighbors(@taxi).sample

      @taxi.position = node.position
    end
  end
end
