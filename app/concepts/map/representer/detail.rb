require 'representable/json'
#require 'roar/json/json_api'

class Map::Representer::Detail < Representable::Decorator
  include Representable::JSON
  #include Roar::JSON::JSONAPI

  property :name
  property :time
end
