class Navigation::Node
  attr_accessor :taxis, :passengers, :blocked

  def initialize
    @blocked = false
    @taxis  = []
    @passengers = []
  end

  def block
    @blocked = true
    self
  end

  def unblocked?
    !blocked?
  end

  def blocked?
    blocked
  end
end
