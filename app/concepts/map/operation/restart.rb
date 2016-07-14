class Map::Operation::Restart < Trailblazer::Operation
  def process(params)
    self.model = Map.find(params[:id])

    MapDetail.new(self.model).restart
  end
end
