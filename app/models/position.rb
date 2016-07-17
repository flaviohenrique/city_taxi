class Position
  attr_reader :row, :col

  def initialize(row, col)
    @row, @col = row, col
  end

  def to_a
    [@row, @col]
  end

  def to_h
    { row: row, col: col}
  end

end
