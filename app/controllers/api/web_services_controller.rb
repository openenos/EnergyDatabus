class Api::WebServicesController < ApplicationController

	$influxdb = InfluxDB::Client.new "openenos"
	def get_monthly_data_by_site_by_month
		if params[:site].present? && params[:month].present?
			starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.strftime("%Y-%m-%d %H:%M:%S")
			ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.strftime("%Y-%m-%d %H:%M:%S")
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

		site_group = params[:site_group]
		if site_group.present? 
			#query = "select sum(power) from power_readings_by_min where time > #{starting_day} and time < #{ending_day} site_group =~ /"+"#{site}" +"/ group by load_type"
			query = "select sum(value) from power_readings_by_hour_new where SiteGroup =~ /.*#{site_group}.*/ and time > now() - 30d and LoadType <> 'Demand' and LoadType <> 'Mains' and LoadType <> 'Energy Production' group by LoadType"
			#query = "select sum(value) from power_readings_new where time > '#{starting_day}' and time < '#{ending_day}' and SiteGroup =~ /"+"#{site_group}" +"/ group by LoadType"
			result = $influxdb.query query
			data = []
			data << ["LoadType", "Value"]
			result.each do |site|

				data << [site["tags"]["LoadType"], (site["values"].first["sum"]).abs.round(2)]
			end
			 
			render :json => { data: data }
		else
			render :json => { message: "Required parameters are Site Group name" }
		end
			
	end

	def get_last_month_data_by_site
		#Get last month power consumption for given site group grouped by site

		if params["month"].present? && params["site_group"].present?
			site_group = params[:site_group]
			query = "select sum(value) from power_readings_by_hour_new where time > now() - 30d and SiteGroup =~ /.*#{site_group}.*/ group by Site"
			#raise query.inspect
			result = $influxdb.query query
			#raise result.inspect
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
			#raise data.inspect
			render :json => {data: data}
		else
			render :json => {message: "Required parameters are month and site group name"}
		end
	end

	def get_live_data_by_site 
		#Code to be re-written for exact data
		site_group = params[:site_group]
		if site_group.present? 

			solar_data =  $influxdb.query "SELECT LAST(value) FROM power_readings_new where LoadType='Energy Production' and SiteGroup=~ /.*#{site_group}.*/ group by Circuit"
			demand_data =  $influxdb.query "SELECT LAST(value) FROM power_readings_new where LoadType='Demand' and SiteGroup=~ /.*#{site_group}.*/ group by Site"
			#raise "SELECT LAST(value) FROM power_readings_new where LoadType='Energy Production' and SiteGroup=~ /"+"#{site_group}" +"/ group by Circuit".inspect
			solar = solar_data.map { |hash| hash["values"].first["last"] }.inject(:+)
			demand = demand_data.map { |hash| hash["values"].first["last"] }.inject(:+)
			
			utility_power = (demand - solar).abs
			render :json => {data: {demand_power: demand, solar_power: solar, utility_power: utility_power} }
		else
			render :json => {message: "Required parameters are site group name"}
		end
	end

	def get_last_year_data
		#Get the data of usage for the past 12 months grouped by month

		#$first_day = (Date.today.beginning_of_month - 12.months)

		site_group = params[:site_group]
		if site_group.present? 
			#demand_data = []
			#solar_data = []
			#demand_value = 0
			#solar_value = 0
			data = []
			from_time = (Date.today.beginning_of_month - 12.months).beginning_of_day.to_time.strftime("%Y-%m-%d %H:%M:%S")
			end_time = (Date.today.beginning_of_month + 1.months).end_of_day.to_time.strftime("%Y-%m-%d %H:%M:%S")
			query = "select sum(value) from power_readings_by_hour_new where time>'#{from_time}' and time<'#{end_time}' and SiteGroup =~ /.*#{site_group}.*/ and LoadType = 'Demand' group by Month"
			#raise query.inspect
			demand_result = $influxdb.query query
			query = "select sum(value) from power_readings_by_hour_new where time>'#{from_time}' and time<'#{end_time}' and SiteGroup =~ /.*#{site_group}.*/ and LoadType = 'Energy Production' group by Month"
			solar_result = $influxdb.query query
			total_demand = 0
			total_solar = 0
			demand_result.each_with_index do |hash, i|
				month = hash["tags"]["Month"]
				demand = hash["values"].first["sum"].present? ? (hash["values"].first["sum"]/1000).abs.round(2) : 0
				solar = solar_result[i]["values"].first["sum"].present? ? (solar_result[i]["values"].first["sum"]/1000).abs.round(2) : 0
				total_solar = total_solar + solar
				total_demand = total_demand + demand
				data << {c: [{v: month}, {v: demand}, {v: solar}]}
			end

			render :json => {data: data, total_demand: total_demand, total_solar: total_solar, utility_power: (total_demand - total_solar).abs.round(2) }

		else
			render :json => {message: "Required parameters are site group name"}
		end

	end
end
