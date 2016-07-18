class Validators::PassengerDestination
  def initialize(record)
    @record = record
    @city_map = CityMap::Builder.new(Map.find(@record.map_id)).build
  end

  def validate
    unless @city_map.valid_passenger_route?(position, dest_position)
      @record.errors[:base] << "can't arrive on destination"
    end
  end

  private

  def position
    Position.new(@record.row, @record.col)
  end

  def dest_position
    Position.new(@record.dest_row, @record.dest_col)
  end
end
