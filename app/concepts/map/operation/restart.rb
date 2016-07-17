class Map::Operation::Restart < Trailblazer::Operation
  def process(params)
    map = Map.find(params[:id])
    self.model = map_builder(map).tap do |city_map|
      city_map.restart
    end
  end

  def map_builder(map)
    CityMap::Builder.new(map).build
  end
end
