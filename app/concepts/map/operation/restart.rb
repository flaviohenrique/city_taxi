class Map::Operation::Restart < Map::Operation::Detail
  def process(params)
    map = Map.find(params[:id])
    self.model = map_builder(map).tap do |city_map|
      city_map.restart
    end
  end
end
