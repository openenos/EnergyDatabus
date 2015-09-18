class Api::SiteAppliancesController < ApplicationController

	$influxdb = InfluxDB::Client.new "openenos"

	def get_last_day_usage
		if params[:site].present?
			site = Site.find_by_display(params[:site])
   		if site.present?
   			data = []
 				query = "select * from power_readings_#{site.id} where time > now() - 24h"
 				result = $influxdb.query query
        result.first["values"].first.delete("Site")
        result.first["values"].first.delete("Main Power")
        data << result.first["values"].first.keys
        result.first["values"].each do |hash|
          hash.delete("Site")
          hash.delete("Main Power")
          hash["time"] = hash["time"].to_time.strftime("%H:%M")
          data << hash.values
        end
        render json: { data: data }

=begin
        #raise result.first["values"].first.inspect
        cols = []
        result.first["values"].first.delete("Site")
        result.first["values"].first.delete("Main Power")
        result.first["values"].first.each do |k,v|
          cols << {"id" => k, "label" => k, "type" => k == "time" ? "string" : "number"}
        end
        result.first["values"].each do |hash|
          hash.delete("Site")
          hash.delete("Main Power")
          row = []
          hash.each do |k,v|
            if k == "time"
              v = v.to_time.strftime("%H:%M")
            end
            row << {"v" => v}
          end
          data << {c: row}
        end
        render json: { cols: cols, data: data }
=end        
 				
   		else
   			render json: { message: "Required a valid site name"}	
   		end
		else
			render json: { message: "Required parameters are site name"}
		end
	end
end
