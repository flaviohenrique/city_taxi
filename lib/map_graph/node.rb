class MapGraph::Node
  attr_reader :name, :row, :col, :blocked

  def initialize(row, col, blocked)
    @name = "#{row} - #{col}"
    @row, @col = row, col
    @blocked = blocked
  end

  def to_s
    name
  end
end
