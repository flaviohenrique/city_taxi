require 'matrix'

class CityMap::Navigator::Builder

  def initialize(graph_builder = Navigation::Graph::Builder.new)
    @graph_builder = graph_builder
  end

  def add_area(rows, cols)
    @grid = ::Matrix.build(rows, cols) do |row, col|
      @graph_builder.add_node(Position.new(row, col))
    end
    self
  end

  def add_blocks(blocks)
    blocks.each { |block| @grid[*block.position.to_a].block! }
    self
  end

  def build
    build_nodes
    CityMap::Navigator.new(@grid, @graph_builder.build)
  end

  private

  def build_nodes
    @grid.each_with_index do |node, row, col|
      edges = []
      edges << @grid[row, col.pred] unless col.zero?
      edges << @grid[row.pred, col] unless row.zero?

      @graph_builder.add_edges(node, edges)
    end
  end
end
