require 'representable/json'
#require 'roar/json/json_api'

class Map::Representer::Show < Representable::Decorator
  include Representable::JSON
  #include Roar::JSON::JSONAPI

  property :id
  property :name
  property :time
end
