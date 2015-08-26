class Api::WebServicesController < ApplicationController

	$influxdb = InfluxDB::Client.new "openenos"
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
		#Get last month power usage for a site group grouped by load type of circuits

		#starting_day = (Date.today - 1.days).to_time.to_i
		#ending_day = (Date.today - 31.days).to_time.to_i
		starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.to_i
		ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.to_i
		#raise [starting_day, ending_day].inspect
		site = params[:site_group]
		if site.present? 
			puts site
			#raise site.inspect
			query = "select sum(power) from power_readings_by_min where time>#{starting_day} and time<#{ending_day} and site_group =~ /"+"#{site}" +"/ group by load_type"
			#raise query.inspect
			result = $influxdb.query query
			data = []
			data << ["load_type", "Value"]
			result.each do |site|

				data << [site["tags"]["load_type"], site["values"].first["sum"]]
			end
			 
			render :json => { data: data }
		else
			render :json => { message: "Required parameters are Site Group name" }
		end
			
	end

	def get_last_month_data_by_site
		#Get last month power consumption for given site group grouped by site

		#starting_day = (Date.today - 1.days).to_time.to_i
		#ending_day = (Date.today - 31.days).to_time.to_i
		if params["month"].present? && params["site"].present?
			starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.to_i
			ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.to_i
			site = params[:site]
			query = "select sum(power) from power_readings_by_min where time>#{starting_day} and time<#{ending_day} and site_group =~ /"+"#{site}" +"/ group by site"
			result = $influxdb.query query
			data = []
			result.each do |site|
				value = site["values"].first["sum"].round(2)
				site_rec = Site.find_by_display(site["tags"]["site"])
				cost = site_rec.location.utility.base_rate * value
				kwh = value/1000
				kwhSqft = site_rec.area_gross_square_foot == 0 ? 0 : kwh/site_rec.area_gross_square_foot
				costSqft = site_rec.area_gross_square_foot == 0 ? 0 : cost/site_rec.area_gross_square_foot
				data << {id: site_rec.id, name: site["tags"]["site"],kwh: kwh.round(2), kwhSqft: kwhSqft.round(2), cost: cost.round(2), costSqft: costSqft.round(2) }
			end
			render :json => {data: data}
		else
			render :json => {message: "Required parameters are month and site group name"}
		end
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
		#Get the data of usage for the past 12 months grouped by month

		#Code to be re-written for exact data
		#solar_data =  $influxdb.query "select sum(value) from power_readings_by_hour where LoadType='Energy Production' and time>'2015-01-01' and time<'2015-10-05' GROUP BY time(30d)"
		#solar_data =  $influxdb.query "select sum(value) from power_readings_by_hour where LoadType='Main Power' and time>'2015-01-01' and time<'2015-10-05' GROUP BY time(30d)"
		$first_day = (Date.today.beginning_of_month - 13.months)
		site = params[:site_group]
		if site.present? 
			demand_data = []
			solar_data = []
			#iterate through each month for 12 times for 12 months
			12.times do
				starting_day = $first_day.beginning_of_day.to_time.to_i
				ending_day = $first_day.end_of_month.end_of_day.to_time.to_i
				ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.to_i
				query = "select sum(power) from power_readings_by_min where time>#{starting_day} and time<#{ending_day} and site_group =~ /"+"#{site}" +"/ and load_type = 'Demand'"
				#raise query.inspect
				result = $influxdb.query query
				if result.empty?
					demand_data << 0
				else
					demand_data << (result.first["values"].first["sum"]/1000).abs
				end
				query = "select sum(power) from power_readings_by_min where time>#{starting_day} and time<#{ending_day} and site_group =~ /"+"#{site}" +"/ and load_type = 'Energy Production'"
				#raise query.inspect
				result = $influxdb.query query
				if result.empty?
					solar_data << 0
				else
					solar_data << (result.first["values"].first["sum"]/1000).abs
				end
				$first_day = $first_day + 1.month
			end
			total_demand = (demand_data.sum/1000).round
			total_solar = (solar_data.sum/1000).round
			render :json => {demand_data: demand_data, solar_data: solar_data, total_demand: total_demand, total_solar: total_solar, utility_power: (total_demand - total_solar).abs }
		else
			render :json => {message: "Required parameters are site group name"}
		end

	end
end
