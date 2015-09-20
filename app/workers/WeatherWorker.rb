require 'influxdb'

class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  #Getting influxdb object and series using influx db config file
  influxdb_config = YAML.load_file('config/influxdb_config.yml')
  $influxdb_config = influxdb_config[Rails.env]
  $database = $influxdb_config["database"]
  $username = $influxdb_config["username"]
  $password = $influxdb_config["password"]

  def perform(station)
    host = "localhost"
    username = $username
    password = $password
    database = $database
    series     = 'temperature_readings'
    time_precision = 'm'
	
	puts "Fetching Weather data for #{station} - Start"
	
	influxdb = InfluxDB::Client.new database, host: host, username: username, password: password, time_precision: time_precision
	
    w_api = Wunderground.new("87e74b8d9511ea00")
    result = w_api.conditions_for("pws:#{station}")
    location = result['current_observation']['observation_location']['city']
    temp = result['current_observation']['temp_c'].to_s
	
	data = {
        values: {value:temp},
		tags: { City: location, Station: station}
    }
	  
    influxdb.write_point(series, data)
	  
    puts "Fetching Weather data for #{station} - End"
  end
end
