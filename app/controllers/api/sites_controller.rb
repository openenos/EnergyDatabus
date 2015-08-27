require 'open-uri'
#require 'wunderground'

class Api::SitesController < ApplicationController
	$influxdb = InfluxDB::Client.new "openenos"
	
	def get_top_circuits_by_site
		if params[:site].present?
			site = Site.find_by_display(params[:site])
			query = "select sum(power) from power_readings_by_min where site =~ /"+"#{params[:site]}" +"/ group by circuit"
			
			result = $influxdb.query query
			data = {}
			result.each do |circuit|
				data[circuit["tags"]["circuit"]] = (circuit["values"].first["sum"]/1000).round
			end
			data.delete("Main Power")
			data.delete("Total Power")
			data = data.sort_by {|k, v| v}.reverse
			data = Hash[(data.first(5))]
			render json: {data: data}
		else
			render json: { message: "Required parameters are site name"}
		end
	end

	def get_last_day_demand
		if params[:site].present?
			$start_time = Time.now - 24.hours
			data = []
			24.times do
				end_time = $start_time + 1.hours
				st = $start_time.strftime("%Y-%m-%d %H:%M:%S")
				et = end_time.strftime("%Y-%m-%d %H:%M:%S")
				query = "select power from power_readings_by_hour where time > #{st} and time < #{et} and site =~ /"+"#{params[:site]}" +"/ and load_type='Demand'"
				result = $influxdb.query query
				data << (result.first["values"].first["sum"]/1000).round
				$start_time = $start_time + 1.hours
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

end
