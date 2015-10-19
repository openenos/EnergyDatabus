class Api::WebServicesController < ApplicationController
	
	#Getting influxdb object and series using influx db config file
	influxdb_config = YAML.load_file('config/influxdb_config.yml')
	$influxdb_config = influxdb_config[Rails.env]
	$database = $influxdb_config["database"]
	$username = $influxdb_config["username"]
  $password = $influxdb_config["password"]
	$min_series = $influxdb_config["series"]["min_table"]
	$hr_series = $influxdb_config["series"]["hour_table"]
	$influxdb = InfluxDB::Client.new $database, username: $username, password: $password
	

	def get_monthly_data_by_site_by_month
		if params[:site].present? && params[:month].present?
			starting_day = (Date.today.beginning_of_year + (params["month"].to_i-1).months).to_time.strftime("%Y-%m-%d %H:%M:%S")
			ending_day = (Date.today.beginning_of_year + (params["month"].to_i).months).to_time.strftime("%Y-%m-%d %H:%M:%S")
			result = $influxdb.query "select sum(value) from #{$hr_series} where time>#{starting_day} and time<#{ending_day} and Site='#{params[:site]}'"
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
			query = "select sum(value) from #{$hr_series} where SiteGroup =~ /.*#{site_group}.*/ and time > now() - 30d and LoadType <> 'Demand' and LoadType <> 'Mains' and LoadType <> 'Energy Production' group by LoadType"
			result = $influxdb.query query
			data = []
			data << ["LoadType", "Value"]
			result.each do |site|

				data << [site["tags"]["LoadType"], (site["values"].first["sum"]/1000).abs.round(2)]
			end
			 
			render :json => { data: data }
		else
			render :json => { message: "Required parameters are Site Group name" }
		end
			
	end

	def get_last_month_data_by_site
		#Get last month power consumption for given site group grouped by site
		load_type = params["load_type"] == "Select Load Type" ? nil : params["load_type"]
		if params["month"].present? && params["site_group"].present?
			site_group = params[:site_group]
			if load_type.present?
				query = "select sum(value) from #{$hr_series} where time > now() - 30d and SiteGroup =~ /.*#{site_group}.*/ and LoadType = '#{load_type}' group by Site"
			else
				query = "select sum(value) from #{$hr_series} where time > now() - 30d and SiteGroup =~ /.*#{site_group}.*/ and LoadType = 'Demand' group by Site"
			end
			result = $influxdb.query query
			data = format_data_by_site(result)
			render :json => {data: data}
		elsif params["site_group"].present? && params["start_date"].present? && params["end_date"].present?
			if load_type.present?
				query = "select sum(value) from #{$hr_series} where time > '#{params[:start_date]}' and time < '#{params[:end_date]}' and LoadType = '#{load_type}' and SiteGroup =~ /.*#{params[:site_group]}.*/ group by Site"
			else
				query = "select sum(value) from #{$hr_series} where time > '#{params[:start_date]}' and time < '#{params[:end_date]}' and LoadType = 'Demand' and SiteGroup =~ /.*#{params[:site_group]}.*/ group by Site"
			end
			
			result = $influxdb.query query
			data = format_data_by_site(result)
			render :json => {data: data}
		else
			render :json => {message: "Required parameters are month and site group name"}
		end
	end

	def get_live_data_by_site 
		#Code to be re-written for exact data
		site_group = params[:site_group]
		if site_group.present? 
			solar_data =  $influxdb.query "SELECT LAST(value) FROM #{$min_series} where LoadType='Energy Production' and SiteGroup=~ /.*#{site_group}.*/ group by Circuit"
			demand_data =  $influxdb.query "SELECT LAST(value) FROM #{$min_series} where LoadType='Demand' and SiteGroup=~ /.*#{site_group}.*/ group by Site"
			#raise "SELECT LAST(value) FROM power_readings_new where LoadType='Energy Production' and SiteGroup=~ /"+"#{site_group}" +"/ group by Circuit".inspect
			solar = solar_data.map { |hash| hash["values"].first["last"] }.inject(:+)
			demand = demand_data.map { |hash| hash["values"].first["last"] }.inject(:+)
			
			utility_power = (demand - solar).abs
			render :json => {data: {demand_power: (demand/1000.0).round(2), solar_power: (solar/1000.0).round(2), utility_power: (utility_power/1000.0).round(2)} }
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
			
			
			query = "select sum(value) from #{$hr_series} where time>'#{from_time}' and time<'#{end_time}' and SiteGroup =~ /.*#{site_group}.*/ and LoadType = 'Demand' group by Month"
			#raise query.inspect
			demand_result = $influxdb.query query
			demand_result = demand_result.reverse
			query = "select sum(value) from #{$hr_series} where time>'#{from_time}' and time<'#{end_time}' and SiteGroup =~ /.*#{site_group}.*/ and LoadType = 'Energy Production' group by Month"
			solar_result = $influxdb.query query
			solar_result = solar_result.reverse
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

			render :json => {data: data, total_demand: total_demand.round(2), total_solar: total_solar.round(2), utility_power: (total_demand - total_solar).abs.round(2) }

		else
			render :json => {message: "Required parameters are site group name"}
		end

	end

	private

	def format_data_by_site(result)
		data = []
		result.each do |site|
			value = site["values"].first["sum"].round(2)
			site_rec = Site.find_by_display(site["tags"]["Site"])
			kwh = value/1000
			cost = site_rec.location.utility.base_rate * kwh
			kwhSqft = site_rec.area_gross_square_foot == 0 ? 0 : kwh/site_rec.area_gross_square_foot
			costSqft = site_rec.area_gross_square_foot == 0 ? 0 : cost/site_rec.area_gross_square_foot
			data << {id: site_rec.id, name: site["tags"]["Site"],kwh: kwh.round(2), kwhSqft: kwhSqft.round(2), cost: cost.round(2), costSqft: costSqft.round(2) }
		end
		return data
	end
end
