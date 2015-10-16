require 'open-uri'
#require 'wunderground'

class Api::SitesController < ApplicationController
	
	#Getting influxdb object and series using influx db config file
	influxdb_config = YAML.load_file('config/influxdb_config.yml')
	$influxdb_config = influxdb_config[Rails.env]
	$database = $influxdb_config["database"]
	$min_series = $influxdb_config["series"]["min_table"]
	$hr_series = $influxdb_config["series"]["hour_table"]
	$username = $influxdb_config["username"]
  $password = $influxdb_config["password"]
  $influxdb = InfluxDB::Client.new $database, username: $username, password: $password


	# Get the top 5 circuits by usage.
	def get_top_circuits_by_site
		if params[:site].present?
			site = Site.find_by_display(params[:site])
			
			data = get_demand_by_circuits
			# Main Power and Total Power not required in the list so remove
			data = data.sort_by {|k, v| v}.reverse

			if params[:all_circuits] == "false"
				data = data.first(5)
			end
			data = data.prepend(["Circuit", "Value"])
			render json: {data: data}
		else
			render json: { message: "Required parameters are site name"}
		end
	end

	def get_last_day_demand
		if params[:site].present?
			$start_time = (Time.now.beginning_of_hour - 24.hours).strftime("%Y-%m-%d %H:%M:%S")
			$end_time = (Time.now.beginning_of_hour).strftime("%Y-%m-%d %H:%M:%S")
			data = []
			query = "select value from #{$min_series} where time > now() - 24h and Site =~ /#{params[:site]}/ and LoadType='Demand'"
			result = $influxdb.query query
			result.first["values"].each do |hash|
				data << {c: [{v: hash["time"].to_time.strftime("%H:%M")}, {v: hash["value"]}]}
			end
			
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name"}
		end
	end

	def get_weather_forecast
		#Get the weather forecast using wunderground api
		if params[:site].present?
			api_key = "87e74b8d9511ea00"
   		wunder = Wunderground.new(api_key)
   		site = Site.find_by_display(params[:site])
   		if site.present?
   			weather_ref = site.location.postal_code.weather_ref
   			result = wunder.conditions_for("pws:#{weather_ref.to_s}")
   			unless result['current_observation'].nil?
   				image = result['current_observation']['icon_url']
			    status = result['current_observation']['weather']
			    temp_f = result['current_observation']['temp_f']
			    wind_string = result['current_observation']['wind_string']
			    relative_humidity = result['current_observation']['relative_humidity']

			    data = {image: image, status: status, temp_f: temp_f, wind_string: wind_string, relative_humidity: relative_humidity}

			    forecast = JSON.load(open("http://api.wunderground.com/api/#{api_key}/forecast/q/pws:#{weather_ref.to_s}.json"))
			    forecast_data = []
			    (1..3).each do|week_day|
			      day_data = { day: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["date"]["weekday"],
			      min: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["low"]["fahrenheit"],
			      max: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["high"]["fahrenheit"] }
			      forecast_data << day_data
			    end
    
    			data['forecast'] = forecast_data
    			render json: { data: data }
   			end
   		else
   			render json: { message: "Required a valid site name"}	
   		end

		else
			render json: { message: "Required parameters are site name"}
		end
	end

	def get_site_demand
		if params[:site].present?
			site = Site.find_by_display(params[:site])
   		if site.present?
   			time = Time.zone.now.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
   			query = "select last(value) from #{$min_series} where LoadType='Demand' and Site=~ /#{params[:site]}/"
   			result = $influxdb.query query
   			value = result.first["values"].first["last"]
   			current_demand = value/1000
   			query = "select max(value) from #{$min_series} where LoadType='Demand' and Site=~ /#{params[:site]}/ and time >= '#{time}'"
   			result = $influxdb.query query
   			value = result.first["values"].first["max"]
   			top_demand = value/1000
   			query = "select sum(value) from #{$hr_series} where LoadType='Demand' and Site=~ /#{params[:site]}/ and time >= '#{time}'"
   			result = $influxdb.query query
   			value = result.first["values"].first["sum"]
   			total_demand = (value/(1000)).round(2)
   			data = { current_demand: current_demand, top_demand: top_demand, total_demand: total_demand }
   			render json: { data: data }
   		else
   			render json: { message: "Required a valid site name"}	
   		end
		else
			render json: { message: "Required parameters are site name"}
		end
	end

	def get_solar_power
		if params[:site].present?
			site = Site.find_by_display(params[:site])
   		if site.present?
   			time = Time.now.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
   			#Query to get the total power so far for current day
   			query = "select sum(value) from #{$min_series} where LoadType='Energy Production' and Site=~ /#{params[:site]}/ and time >= '#{time}' group by Circuit"
   			result = $influxdb.query query
   			total_power = result.map { |hash| hash["values"].first["sum"] }.inject(:+)
   			total_power = (total_power/1000.0).round(2)

   			#Query to get Current/Live power 
   			query = "select last(value) from #{$min_series} where LoadType='Energy Production' and Site=~ /#{params[:site]}/ and time >= '#{time}' group by Circuit"
   			result = $influxdb.query query
   			current_power = result.map { |hash| hash["values"].first["last"] }.inject(:+)
   			
   			render json: {data: { current_power: current_power, total_power: total_power} }
   		else
   			render json: { message: "Required a valid site name"}	
   		end
		else
			render json: { message: "Required parameters are site name"}
		end

	end

	def get_top_demand
		if params[:site].present?
			site = Site.find_by_display(params[:site])
   		if site.present?
   			data = get_demand_by_circuits
   			data = data.sort_by {|k, v| v}.reverse.first(10)
   			render json: { data: data }
   		else
   			render json: { message: "Required a valid site name"}	
   		end
		else
			render json: { message: "Required parameters are site name"}
		end
	end

	def get_cost_predictions
		if params[:site].present?
			site = Site.find_by_display(params[:site])
   		if site.present?

   			#cost predictions for day so far
   			today = Time.zone.now.beginning_of_day		
   			hours = Time.zone.now.hour 							#hours so far
   			time = today.strftime("%Y-%m-%d %H:%M:%S")
   			query = "select sum(value) from #{$hr_series} where LoadType='Demand' and Site='#{params[:site]}' and time > '#{time}'"
   			result = $influxdb.query query
   			demand_today = (result.first["values"].first["sum"])/1000
   			cost_today = demand_today * site.location.utility.base_rate 			#cost so far
   			cost_prediction = (cost_today/hours)*24 													#cost predictions for day

   			#cost predictions for month
   			month_start = today.beginning_of_month
   			days = today.day 					#days so far
   			month_days = today.end_of_month.day 			#total days for current month
   			time = month_start.strftime("%Y-%m-%d %H:%M:%S")
   			query = "select sum(value) from #{$hr_series} where LoadType='Demand' and Site='#{params[:site]}' and time > '#{time}'"
   			result = $influxdb.query query
   			demand_month = (result.first["values"].first["sum"])/1000
   			month_prediction = (demand_month/days)*month_days 								#cost predictions for month
   			render json: { cost_today: cost_today.round(2), cost_prediction: cost_prediction.round(2), month_prediction: month_prediction.round(2) }
   		else
   			render json: { message: "Required a valid site name"}	
   		end	
		else
			render json: { message: "Required parameters are site name"}
		end
	end
 
 	private

 	def get_demand_by_circuits
 		query = "select LAST(value) from #{$min_series} where Site =~ /#{params[:site]}/ and Circuit <> 'Main Power' and Circuit <> 'Total Power' and Circuit <> 'Solar Input' group by Circuit"
		result = $influxdb.query query
		data = {}
		result.each do |circuit|
			data[circuit["tags"]["Circuit"]] = (circuit["values"].first["last"]).round(2)
		end
		return data

 	end
end
