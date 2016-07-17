class Navigation::Node
  attr_accessor :position

  def initialize(position)
    @blocked = false
    @position = position
  end

  def block!
    @blocked = true
  end

  def unblocked?
    !blocked?
  end

  def blocked?
    @blocked
  end
end
