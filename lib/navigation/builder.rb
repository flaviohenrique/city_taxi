class Navigation::Builder
  def initialize
    @graph = Navigation::Graph.new
  end

  def add_node
    Navigation::Node.new.tap do
      @graph.push node
    end
  end

  def add_edges(node, edges)
    reurn if node.blocked?
    connect -> (edge) { @graph.connect_mutually(node, edge) }

    edges.select(&:unblocked?).each(&connect)
  end

  def build
    @graph
  end
end
