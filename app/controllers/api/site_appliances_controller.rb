class Api::SiteAppliancesController < ApplicationController

	$influxdb = InfluxDB::Client.new "openenos"

	def get_last_day_usage
		if params[:site].present?
			site = Site.find_by_display(params[:site])
   		if site.present?
   			data = []
   			
   				query = "select value, Circuit from power_readings_new where time > now() - 24h and Site=~ /Rosedale Cafe/"
   				result = $influxdb.query query
   				raise result.inspect
   				result.map {|hash| hash.delete("name") }
   				raise result.second.inspect
   				result.each do |hash|
						values = hash["values"]
						data << {circuit.display => values}
					end
   		else
   			render json: { message: "Required a valid site name"}	
   		end
		else
			render json: { message: "Required parameters are site name"}
		end
	end
end
