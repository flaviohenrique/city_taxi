class Map::Contract::Create < Reform::Form
  property :name
  property :file, virtual: true

  validates :name, presence: true
  validates :file, presence: true
end
