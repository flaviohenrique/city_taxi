require 'representable/json'

class PassengerRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :row
  property :col
  property :dest_row
  property :dest_col
  property :map_id
end
