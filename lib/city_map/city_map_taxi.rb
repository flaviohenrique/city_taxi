class CityMap
  class CityMapTaxi
    delegate  :name,
              :passenger,
              :status,
              :status=,
              :empty?,
              :position, to: :@taxi

    def initialize(taxi, navigator, runner_factory = Runner::Factory.new)
      @taxi           = taxi
      @navigator      = navigator
      @runner_factory = runner_factory
    end

    def run
      @runner_factory.create(self).run_on(@navigator)
      @taxi.save
    end

    def passenger
      @passenger ||= (@taxi.passenger && CityMapPassenger.new(@taxi.passenger, @navigator))
    end

    def going_to_passenger(passenger)
      @taxi.update_attributes(status: :going, passenger: passenger)
    end

    def remove_passenger
      @taxi.passenger.mark_for_destruction
    end

    def on(position)
      @taxi.row == position.row && @taxi.col == position.col
    end

    def position=(position)
      @taxi.assign_attributes(position.to_h)
    end

    def position
      Position.new(@taxi.row, @taxi.col)
    end
  end
end
