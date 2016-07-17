class CityMap
  attr_accessor :map

  def initialize(map, layers)
    @map = map
    @layers = layers
  end

  def id
    @map.id
  end

  def name
    @map.name
  end

  def time
    @map.time
  end

  def rows
    @map.rows
  end

  def cols
    @map.cols
  end

  def [](row, col)
    @layers.grid[row, col]
  end

  def find_taxi(position)
    @map.taxis.where(position.to_h)
  end

  def find_waiting_passenger(position)
    @map.passengers.where(position.to_h).not_going
  end

  # def grid
  #   @layers.grid
  # end

  def move
    Map.transaction do
      match_taxis
      move_empty_taxis
      move_full_taxis
      move_going_taxis
      time_tick_map
    end
  end

  def restart
    Map.transaction do
      @map.taxis.destroy_all
      @map.passengers.destroy_all
      @map.update_attributes(time: 0)
    end
  end

  def time_tick_map
    @map.update_attributes(time: @map.time.next)
  end

  def match_taxis
    @map.passengers
      .calling
      .each{ |taxi| nearest_taxi(taxi) }
  end

  def move_full_taxis
    @map.taxis
      .full
      .includes(:passenger)
      .each { |taxi| move_full_taxi(taxi) }
  end

  def move_empty_taxis
    @map.taxis.empty.each { |taxi| move_randomly(taxi) }
  end

  def move_going_taxis
    @map.taxis.going.each { |taxi| move_going_taxi(taxi) }
  end

  private

  def move_randomly(taxi)
    node = @layers.taxi_neighbors(taxi).sample

    taxi.update_attributes(node.position.to_h)
  end

  def move_going_taxi(taxi)
    next_node, passenger_node = @layers.taxi_passenger_next_node(taxi)
    move_taxi_to_passenger(taxi, next_node, passenger_node)
  end

  def move_full_taxi(taxi)
    next_node, dest_node = @layers.taxi_destination_next_node(taxi)
    move_taxi_to_destination(taxi, next_node, dest_node)
  end

  def move_taxi_to_passenger(taxi, next_node, passenger_node)
    taxi.position = next_node.position

    if next_node == passenger_node
      taxi.status = :full
      taxi.passenger.status = :going
    end
    taxi.save
  end

  def move_taxi_to_destination(taxi, next_node, destination_node)
    taxi.position = next_node.position

    if next_node == destination_node
      taxi.status = :empty
      taxi.passenger.mark_for_destruction
    end
    taxi.save
  end

  def nearest_taxi(passenger)
    taxi = @layers.nearest_taxi(passenger , @map.taxis.empty)

    link_taxi_and_passenger(taxi, passenger)
  end

  def link_taxi_and_passenger(taxi, passenger)
    passenger.status = :waiting
    taxi.status = :going

    taxi.passenger = passenger
    taxi.save && passenger.save
  end
end
