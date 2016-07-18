class CityMap
  class CityMapPassenger
    delegate  :name,
              :status,
              :status=, to: :@passenger

    def initialize(passenger, navigator)
      @passenger = passenger
      @navigator = navigator
    end

    def call_taxi(taxis)
      return unless @passenger.calling?

      taxi = @navigator.nearest_taxi(self, taxis.select(&:empty?))
      waiting_for(taxi) if taxi
    end

    def waiting_on(position)
      on(position) && !@passenger.going?
    end

    def on(position)
      @passenger.row == position.row && @passenger.col == position.col
    end

    def position=(position)
      @passenger.assign_attributes(position.to_h)
    end

    def position
      Position.new(@passenger.row, @passenger.col)
    end

    def dest_position=(position)
      @passenger.assign_attributes(dest_row: position.row, dest_col: position.col)
    end

    def dest_position
      Position.new(@passenger.dest_row, @passenger.dest_col)
    end

    private

    def waiting_for(taxi)
      @passenger.status = :waiting

      taxi.going_to_passenger(@passenger) && @passenger.save
    end
  end
end
