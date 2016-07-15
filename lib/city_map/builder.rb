class CityMap::Builder
  def initialize(map, layer_builder = CityMaplayerBuilder.new)
    @map = map
    layer_builder.add_area(@map.rows, @map.cols)
  end

  def build
     layers = layer_builder.add_taxis(@map.taxis)
                  .add_passengers(@map.passengers)
                  .add_blocks(@map.blocks)
                  .build

    CityMap.new(@map, layers)
  end
end
