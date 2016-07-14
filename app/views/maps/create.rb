class Taxi::CreateForm < Reform::Form
  property :name
  property :row
  property :col
  property :map_id

  validates :name, presence: true
  validates :row, presence: true
  validates :col, presence: true
  validates :map_id, presence: true, inclusion: { in: ->(taxi) { Map.pluck(:id) } }
end
