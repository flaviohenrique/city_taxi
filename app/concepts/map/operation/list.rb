class Map::Operation::List < Trailblazer::Operation
  include Responder
  include Representer
  include Collection

  representer Map::Representer::List

  def model!(params)
    Map.all
  end

  def process(params)

  end
end
