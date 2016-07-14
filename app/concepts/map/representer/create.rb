require 'representable/json'
#require 'roar/json/json_api'

class Map::Representer::Create < Representable::Decorator
  include Representable::JSON
  #include Roar::JSON::JSONAPI

  property :id
  property :name
  property :time
end
