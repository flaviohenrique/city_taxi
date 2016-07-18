class Passenger::CreateForm < Reform::Form
  property :name

  property :row
  property :col
  property :dest_row
  property :dest_col

  property :map_id

  validates :name,      presence: true
  validates :row,       presence: true
  validates :col,       presence: true
  validates :dest_row,  presence: true
  validates :dest_col,  presence: true

  validates :map_id,  presence: true,
                      inclusion: { in: ->(pass) { Map.pluck(:id) } }

  validate do |passenger|
    Validators::Position.new(passenger).validate(:row, :col)
    Validators::Position.new(passenger).validate(:dest_row, :dest_col)
  end

  validate do |passenger|
    Validators::PassengerDestination.new(passenger).validate
  end
end
