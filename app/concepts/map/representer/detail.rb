require 'representable/json'
#require 'roar/json/json_api'

class Map::Representer::Detail < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :time
  property :rows
  property :cols
  collection :area, decorator: Map::Representer::DetailRow
end
