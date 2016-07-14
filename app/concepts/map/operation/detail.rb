class Map::Operation::Detail < Trailblazer::Operation
  include Representer

  representer Map::Representer::Detail

  def process(params)
    self.model = MapDetail.new(Map.find(params[:id]))
  end
end
