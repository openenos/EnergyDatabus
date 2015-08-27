require 'open-uri'
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
				st = $start_time.to_i
				et = end_time.to_i
				query = "select sum(power) from power_readings_by_min where time > #{st} and time < #{et} and site =~ /"+"#{params[:site]}" +"/ and load_type='Demand' "
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
   			end
   		else
   			render json: { message: "Required a valid site name"}	
   		end

		else
			render json: { message: "Required parameters are site name"}
		end

	end
end
