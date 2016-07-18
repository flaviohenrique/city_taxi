class Map::Operation::Detail < Trailblazer::Operation
  include Representer

  representer Map::Representer::Detail

  def process(params)
    self.model = map_builder(Map.find(params[:id]))
  end

  def map_builder(map)
    CityMap::Builder.new(map).build
  end

  def to_model
    model
  end
end
