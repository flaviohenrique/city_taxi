class CityMap::Layer::Builder

  def initialize(navigation_builder = Navigation::Builder.new)
    @navigation_builder = navigation_builder
  end

  def add_area(rows, cols)
    @grid = Matrix.build(rows, cols) do
      @navigation_builder.add_node
    end
  end

  def add_taxis(taxis)
    taxis.each do |taxi|
      @grid[taxi.row, taxi.col].taxis << taxi
    end
  end

  def add_blocks(blocks)
    blocks.each do |block|
      @grid[block.row, block.col].blocked
    end
  end

  def add_passengers(passengers)
    passengers.each do |passenger|
      @grid[passenger.row, passenger.col].passengers << passenger
    end
  end

  def build
    build_nodes
    CityMap::Layer.new(@grid, @navigation_builder.build)
  end

  private

  def build_nodes
    @grid.each_with_index do |node, row, col|
      edges = []
      edges << @grid[row, col.prev] unless col.zero?
      edges << @grid[row.prev, col] unless row.zero?

      @navigation_builder.add_edges(node, edges)
    end
  end
end
