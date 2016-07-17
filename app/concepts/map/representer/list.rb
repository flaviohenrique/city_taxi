require 'representable/json'
#require 'roar/json/json_api'

class Map::Representer::List < Representable::Decorator
  include Representable::JSON::Collection

  items decorator: Map::Representer::Show
end
