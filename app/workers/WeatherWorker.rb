require 'influxdb'

class WeatherWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    host = "localhost"
    username = 'enos'
    password = 'p@ssw0rd'
    database = 'openenos'
    series     = 'temperature_readings'
    time_precision = 'm'
	station = 'KFLPALME10'
	
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
