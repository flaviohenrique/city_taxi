require 'representable/json'
#require 'roar/json/json_api'

class Map::Representer::DetailRow < Representable::Decorator
  include Representable::JSON::Collection

  items do
    property :row
    property :col
    property :blocked
    collection :taxis do
      property :name
      property :status
    end
    collection :passengers do
      property :name
      property :status
    end
  end
end
