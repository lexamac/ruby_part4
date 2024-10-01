class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    trains.filter { |train| train.type == type }
  end

  def add_train(train)
    trains << train
  end

  def send_train
    trains.shift if !trains.empty?
  end
end

class Route
  attr_reader :stations, :start_station, :end_station

  def initialize
    @stations = []
  end

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remvoe_station
    stations.delete_at(-2) if @stations.length > 2
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end
end

class Train
  attr_reader :speed, :type, :wagon_count

  def initialize(number, type, wagon_count)
    @number = number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
    @route = Route.new
  end

  def increase_speed
    speed += 1
  end

  def stop
    speed = 0
  end

  def add_wagon
    wagon_count += 1 if speed == 0
  end

  def remove_wagon
    wagon_count += 1 if speed == 0 && wagon_count > 0
  end

  def set_route(route)
    @route = route

    @station_position = 0
    current_station.add_train(self)
  end

  def move_forward
    return unless @route.nil? || @route.end_station == current_station

    current_station.send_train
    @station_position += 1
    current_station.add_train(self)
  end

  def move_backward
    return unless @route.nil? || @route.start_station == current_station

    current_station.send_train
    @station_position -= 1
    current_station.add_train(self)
  end

  def current_station
    @route.stations[@station_position]
  end

  def next_station
    @route.stations[@station_position + 1]
  end

  def previous_station
    @route.stations[@station_position - 1]
  end
end
