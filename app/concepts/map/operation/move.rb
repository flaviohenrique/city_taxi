class Map::Operation::Move < Trailblazer::Operation
  def process(params)
    self.model = Map.find(params[:id])

    MapDetail.new(self.model).move
  end
end
