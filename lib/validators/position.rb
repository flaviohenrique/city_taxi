class Validators::Position
  def initialize(record)
    @record = record
  end

  def validate(row_field, col_field)
    if MapBlock.exists?(row: @record.send(row_field), col: @record.send(col_field), map_id: @record.map_id)
      [row_field, col_field].each { |field| @record.errors[field] << "is blocked" }
    end
  end
end
