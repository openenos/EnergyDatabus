class Api::SiteCircuitController < ApplicationController

	#Getting influxdb object and series using influx db config file
	influxdb_config = YAML.load_file('config/influxdb_config.yml')
	$influxdb_config = influxdb_config[Rails.env]
	$database = $influxdb_config["database"]
	$min_series = $influxdb_config["series"]["min_table"]
	$hr_series = $influxdb_config["series"]["hour_table"]
	$runtime_series = $influxdb_config["series"]["runtime_series"]
	$username = $influxdb_config["username"]
  $password = $influxdb_config["password"]
  $influxdb = InfluxDB::Client.new $database, username: $username, password: $password

  #get the runtime of a circuit for specified times
	def get_runtime_info
		site = Site.find_by_display(params["site"])
		circuit = Circuit.find_by_display(params["circuit"])
		if site.present? && circuit.present?
			day_query = "select sum(value) from #{$runtime_series} where time > now() - 1d  and Site = '#{params[:site]}' and Circuit = '#{params[:circuit]}'"
			week_query = "select sum(value) from #{$runtime_series} where time > now() - 1w  and Site = '#{params[:site]}' and Circuit = '#{params[:circuit]}'"
			total_query = "select sum(value) from #{$runtime_series} where Site = '#{params[:site]}' and Circuit = '#{params[:circuit]}'"
			day_values = get_hours_minutes(day_query)
			week_values = get_hours_minutes(week_query)
			total_values = get_hours_minutes(total_query)
			render json: { data: {:day => day_values, :week => week_values, :total => total_values } }
		else
			render json: { message: "Required parameters are site and circuit"}
		end
	end

	#get the current demand and total demand for past 30 days for a circuit
	def get_circuit_demand
		site = Site.find_by_display(params["site"])
		circuit = Circuit.find_by_display(params["circuit"])
		if site.present? && circuit.present?
			result = $influxdb.query "SELECT LAST(value) FROM #{$min_series} where Site = '#{site.display}' and Circuit = '#{circuit.display}'"
			current_demand = result.first["values"].first["last"]
			result = $influxdb.query "select sum(value) from #{$hr_series} where Site = '#{site.display}' and Circuit = '#{circuit.display}' and time > now() - 30d "
			total_demand = (result.first["values"].first["sum"]/1000).round(2)

			render json: { data: { current_demand: current_demand, total_demand: total_demand }}

		else
			render json: { message: "Required parameters are site and circuit"}
		end
	end

	#get the circuit demand for a given day
	def get_day_circuit_demand
		site = Site.find_by_display(params["site"])
		circuit = Circuit.find_by_display(params["circuit"])
		if site.present? && circuit.present?
			start_time = params["date"].to_date.to_time
			end_time = start_time.end_of_day
			query = "select value from #{$min_series} where Site = '#{site.display}' and Circuit = '#{circuit.display}' and time > '#{start_time.strftime("%Y-%m-%d %H:%M:%S")}' and time < '#{end_time.strftime("%Y-%m-%d %H:%M:%S")}'"
			result = $influxdb.query query
			data = []
			data << ["Time", "Value"]
			result.first["values"].each do |hash|
				hash["time"] = hash["time"].to_time.strftime("%H:%M")
				hash["value"] ||= 0
				hash["value"] = hash["value"].round(2)
				data << hash.values
			end
			render json: { data: data }
		else
			render json: { message: "Required parameters are site and circuit"}
		end
	end

	#get the circuit demand for given week
	def get_week_circuit_demand
		site = Site.find_by_display(params["site"])
		circuit = Circuit.find_by_display(params["circuit"])
		if site.present? && circuit.present?
			start_time = params["date"].to_date.to_time
			end_time = start_time.end_of_day + 7.days
			query = "select sum(value) from #{$hr_series} where Site = '#{site.display}' and Circuit = '#{circuit.display}' and time > '#{start_time.strftime("%Y-%m-%d %H:%M:%S")}' and time < '#{end_time.strftime("%Y-%m-%d %H:%M:%S")}' group by time(1h) "
			result = $influxdb.query query
			data = []
			data << ["Time", "Value"]
			result.first["values"].each do |hash|
				hash["time"] = hash["time"].to_time.strftime("%b %d, %H:%M")
				hash["sum"] ||= 0
				hash["sum"] = hash["sum"].round(2)
				data << hash.values
			end
			render json: { data: data }
		else
			render json: { message: "Required parameters are site and circuit"}
		end
	end

	#get the circuit demand for given month
	def get_month_circuit_demand
		site = Site.find_by_display(params["site"])
		circuit = Circuit.find_by_display(params["circuit"])
		if site.present? && circuit.present?
			start_time = params["date"].to_date.beginning_of_month
			end_time = start_time.end_of_day.end_of_month
			query = "select sum(value) from #{$hr_series} where Site = '#{site.display}' and Circuit = '#{circuit.display}' and time > '#{start_time.strftime("%Y-%m-%d %H:%M:%S")}' and time < '#{end_time.strftime("%Y-%m-%d %H:%M:%S")}' group by time(1d)"
			result = $influxdb.query query
			data = []
			data << ["Time", "Value"]
			result.first["values"].each do |hash|

				hash["time"] = hash["time"].to_time.strftime("%b %d")
				hash["sum"] ||= 0
				hash["sum"] = hash["sum"].round(2)
				data << hash.values
			end 
				
			render json: { data: data }
		else
			render json: { message: "Required parameters are site and circuit"}
		end
	end

	private

	def get_hours_minutes(query)
		result = $influxdb.query query
		value = result.first["values"].first["sum"]
		hours = value/60
		mins = value%60
		return { :hours => hours, :mins => mins }
	end
end
