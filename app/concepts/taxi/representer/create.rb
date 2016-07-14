require 'representable/json'

class TaxiRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :row
  property :col
  property :map_id
  property :status
end
