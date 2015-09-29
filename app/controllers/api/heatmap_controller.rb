class Api::HeatmapController < ApplicationController

	influxdb_config = YAML.load_file('config/influxdb_config.yml')
	$influxdb_config = influxdb_config[Rails.env]
	$database = $influxdb_config["database"]
	$min_series = $influxdb_config["series"]["min_table"]
	$username = $influxdb_config["username"]
  $password = $influxdb_config["password"]
  $influxdb = InfluxDB::Client.new $database, username: $username, password: $password

	def get_heat_map
		start_date = Date.today - 7.days
		start_time = start_date.to_time.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
		end_date = Date.today - 1.days
		end_time = end_date.to_time.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
		x_min = 20
		y_min = 600
		query = "select mean(value) from #{$min_series} where Site='#{params[:site]}' and time > '#{start_time}' and time < '#{end_time}' and LoadType='Demand' group by time(5m)"
		result = $influxdb.query query
		result = result.first["values"]
		
		x,y,data,i,max = x_min, y_min, [], 0, 0
		result.each do |hash|
			if i >= 289
				i = 0
			end
			if i == 0
				x, y = x_min, y - 80
			else
				x, y = x + 4, y
			end
			value = hash["mean"] || 20
			i = i+1
			max = max > value ? max : value
			data << {x: x, y: y, value: value.round(2)}
		end
		render json: { data: data, max: max }
	end
end
