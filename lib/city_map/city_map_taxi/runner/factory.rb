class CityMap::CityMapTaxi
  class Runner::Factory
    def create(taxi)
      case taxi.status.to_sym
      when :empty then EmptyRunner.new(taxi)
      when :going then GoingRunner.new(taxi)
      when :full  then FullRunner.new(taxi)
      end
    end
  end
end
