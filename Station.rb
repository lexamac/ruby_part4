class Station

  attr_reader :trains

  def initialize(station_name)
    @station_name = station_name
    @trains = []
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

  attr_reader :stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @stations = []
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
end


class Train

  attr_reader :speed, :type, :wagon_count, :current_station, :previous_station, :next_station

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

  def stop
    @speed = 0
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
    @previous_station = @route.stations[0]
    @next_station = @route.stations[1]
  end

  def move_forward
    if !@route.nil? && @route.end_station != @current_station
      @previous_station = @current_station
      @current_station.send_train
      @current_station = @next_station
      @current_station.add_train(self)
      @station_position += 1
      @next_station = @route.end_station != @current_station ? @route.stations[@station_position + 1] : nil
    end
  end

  def move_backward
    if !@route.nil? && @route.start_station != @current_station
      @next_station = @current_station
      @current_station.send_train
      @current_station = @route.stations[@station_position - 1]
      @current_station.add_train(self)
      @station_position -= 1
      @previous_station = @route.start_station != @current_station ? @route.stations[@station_position - 1] : @next_station
    end
  end
end
