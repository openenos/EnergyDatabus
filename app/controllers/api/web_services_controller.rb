class Api::WebServicesController < ApplicationController

	$influxdb = InfluxDB::Client.new host: "54.203.254.118", database:  "openenos"
	def get_monthly_data_by_site_by_month
		if params[:site].present? && params[:month].present?
			starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.to_i
			ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.to_i
			result = $influxdb.query "select sum(value) from power_readings_by_hour where time>#{starting_day} and time<#{ending_day} and Site='#{params[:site]}'"
			if result.empty?
				value = 0
			else
				value = result.first["values"].first["sum"] 
			end
			render :json => {:success => true, :site => params[:site], value: value }
		else
			render :json => {:success => false, :message => "Required params are site name and month"}
		end

	end

	def get_last_month_data_by_load_type
		#starting_day = (Date.today - 1.days).to_time.to_i
		#ending_day = (Date.today - 31.days).to_time.to_i
		starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.to_i
		ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.to_i
		result = $influxdb.query "select sum(value) from power_readings_by_hour where time>#{starting_day} and time<#{ending_day} group by LoadType"
		data = []
		data << ["LoadType", "Value"]
		result.each do |site|

			data << [site["tags"]["LoadType"], site["values"].first["sum"]]
		end
		 
		render :json => { data: data }
			
	end

	def get_last_month_data
		#starting_day = (Date.today - 1.days).to_time.to_i
		#ending_day = (Date.today - 31.days).to_time.to_i
		starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.to_i
		ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.to_i
		result = $influxdb.query "select sum(value) from power_readings_by_hour where time>#{starting_day} and time<#{ending_day} group by Site"
		data = []
		result.each do |site|
			value = site["values"].first["sum"].round(2)
			site_rec = Site.find_by_display(site["tags"]["Site"])
			cost = site_rec.location.utility.base_rate * value
			kwh = value/1000
			kwhSqft = site_rec.area_gross_square_foot == 0 ? 0 : kwh/site_rec.area_gross_square_foot
			costSqft = site_rec.area_gross_square_foot == 0 ? 0 : cost/site_rec.area_gross_square_foot
			data << {id: site_rec.id, name: site["tags"]["Site"],kwh: kwh.round(2), kwhSqft: kwhSqft.round(2), cost: cost.round(2), costSqft: costSqft.round(2) }
		end
		render :json => {data: data}
	end

	def get_live_data_by_site 
		#Code to be re-written for exact data
		solar_data =  $influxdb.query "select value from power_readings_by_min where LoadType='Energy Production' limit 1"
		demand_data =  $influxdb.query "select value from power_readings_by_min where LoadType='Main Power' limit 1"
		solar_power = solar_data.empty? ? 0 : solar_data.first["values"].first["value"]
		demand_power = demand_data.empty? ? 0 : demand_data.first["values"].first["value"]
		utility_power = demand_power - solar_power
		render :json => {demand_power: demand_power, solar_power: solar_power, utility_power: utility_power}
	end

	def get_last_year_data
		#Code to be re-written for exact data
		solar_data =  $influxdb.query "select sum(value) from power_readings_by_hour where LoadType='Energy Production' and time>'2015-01-01' and time<'2015-10-05' GROUP BY time(30d)"
		solar_data =  $influxdb.query "select sum(value) from power_readings_by_hour where LoadType='Main Power' and time>'2015-01-01' and time<'2015-10-05' GROUP BY time(30d)"
	end
end
