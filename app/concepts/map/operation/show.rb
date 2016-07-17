class Map::Operation::Show < Trailblazer::Operation
  include Responder
  include Representer
  include Model

  model Map, :find

  representer Map::Representer::Show
end
