class CityMap
  class Builder
    def initialize(map, nav_builder = CityMap::Navigator::Builder.new)
      @map = map
      @nav_builder = nav_builder
    end

    def build
      navigator = @nav_builder
        .add_area(@map.rows, @map.cols)
        .add_blocks(@map.blocks)
        .build

      CityMap.new(@map, navigator, build_taxis(navigator), build_passengers(navigator))
    end

    private

    def build_taxis(navigator)
      @map.taxis.map { |taxi| CityMap::CityMapTaxi.new(taxi, navigator)  }
    end

    def build_passengers(navigator)
      @map.passengers.map { |passenger| CityMap::CityMapPassenger.new(passenger, navigator)  }
    end
  end
end
