class Map::Operation::Move < Map::Operation::Detail
  def process(params)
    self.model = map_builder(Map.find(params[:id])).tap do |city_map|
      city_map.move
    end
  end
end
