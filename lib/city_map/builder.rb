class CityMap::Builder
  def initialize(map, layer_builder = CityMap::Layer::Builder.new)
    @map = map
    @layer_builder = layer_builder
  end

  def build
    layers = @layer_builder
      .add_area(@map.rows, @map.cols)
      .add_blocks(@map.blocks)
      .build
    # .add_taxis(@map.taxis)
    # .add_passengers(@map.passengers)
    CityMap.new(@map, layers)
  end
end
