class Station
  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def trains
    @trains
  end

  def trains_by_type(type)
    puts @trains.filter { |train| train.type == type }
  end

  def add_train(train)
    @trains << train
  end

  def send_train
    @trains.shift if !trains.empty?
  end
end


class Route
  @stations = []

  def initialize(start_station, end_station)
    @start_station = start_station
    @stations << start_station
    @end_station = end_station
    @stations << end_station
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remvoe_station
    @stations.delete_at(-2) if @stations.length > 2
  end

  def stations
    @stations
  end

  def start_station
    @start_station
  end

  def end_station
    @end_station
  end
end


class Train
  def initialize(number, type, wagon_count)
    @number = number
    @type = type
    @wagon_count = wagon_count
    @speed = 0
    @route = nil
  end

  def increase_speed
    @speed += 1
  end

  def speed
    @speed
  end

  def type
    @type
  end

  def stop
    @speed = 0
  end

  def wagon_count
    @wagon_count
  end

  def add_wagon
    @wagon_count += 1 if @speed == 0
  end

  def remove_wagon
    @wagon_count += 1 if @speed == 0 && @wagon_count > 0
  end

  def set_route(route)
    @route = route

    @station_position = 0
    @current_station = @route.stations[0]
    @current_station.add_train(self)
    @last_station = @route.stations[0]
    @next_station = @route.stations[1]
  end

  def current_station
    @current_station
  end

  def last_station
    @last_station
  end

  def next_station
    @next_station
  end

  def move_forward
    if !@route.nil? && @route.stations.length > @station_position
      @last_station = @current_station
      @current_station.send_train
      @current_station = @next_station
      @current_station.add_train(self)
      @station_position += 1
      @next_station = @route.stations[@station_position + 1]
    end
  end

  def move_backward
    if !@route.nil? && @station_position > 0
      @next_station = @current_station
      @current_station.send_train
      @current_station = @last_station
      @current_station.add_train(self)
      @station_position -= 1
      @last_station = @route.stations[@station_position - 1]
    end
  end
end
