class CityMap
  class CityMapNode
    attr_accessor :blocked,
                  :passengers,
                  :taxis,
                  :row,
                  :col

    def initialize(row, col, blocked, passengers, taxis)
      @row = row
      @col = col
      @blocked = blocked
      @passengers = passengers
      @taxis = taxis
    end
  end
end
