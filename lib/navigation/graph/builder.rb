class Navigation::Graph::Builder
  def initialize
    @graph = Navigation::Graph.new
  end

  def add_node(position)
    Navigation::Node.new(position).tap do |node|
      @graph.push node
    end
  end

  def add_edges(node, edges)
    return if node.blocked?
    connect = -> (edge) { @graph.connect_mutually(node, edge) }

    edges.select(&:unblocked?).each(&connect)
  end

  def build
    @graph
  end
end
