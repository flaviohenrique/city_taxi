class Map::Operation::Move < Trailblazer::Operation
  def process(params)
    self.model = map_builder(Map.find(params[:id]))

    self.model.move
  end

  def map_builder(map)
    CityMap::Builder.new(map).build
  end
end
