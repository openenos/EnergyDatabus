class Api::SiteUsageController < ApplicationController
	
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
	
	def get_year_usage_data_by_site
		#To get the usage for site for a year

		if params[:site].present? && params[:year].present?
			site = Site.find_by_display(params[:site])
			if site.present?
				data = get_year_data("Demand")
				render json: { data: data }
			else
				render json: { message: "Required a valid site name"}
			end
		else
			render json: { message: "Required parameters are site name and year"}
		end
	end

	def get_month_usage_data_by_site
		#To get the usage for site for a month
		
		if params[:site].present? && params[:year].present? && params[:month].present?
			value = get_month_data("Demand")
			render json: { data: value }
		else
			render json: { message: "Required parameters are site name and year and month"}
		end
	end

	def get_week_usage_data_by_site
		#To get the usage for site for a week

		if params[:site].present? && params[:date]
			start_time = params["date"].to_date.to_time
			end_time = (params["date"].to_date + 6.days).to_time.end_of_day
			data = get_week_data(params["load_type"], start_time, end_time)
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name and week start date"}
		end
	end

	def get_day_usage_data_by_site
		#To get the usage for site for a day

		if params[:site].present? && params[:date]
			start_time = params["date"].to_date.to_time
			end_time = start_time.end_of_day
			data = get_day_data(params["load_type"], start_time, end_time)
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name and date"}
		end
	end

	def get_year_production_data_by_site 
		#To get the production for site for a year

		if params[:site].present? && params[:year].present?
			site = Site.find_by_display(params[:site])
			if site.present?
				data = get_year_data("Energy Production")
				render json: { data: data }
			else
				render json: { message: "Required a valid site name"}
			end
		else
			render json: { message: "Required parameters are site name and year"}
		end
	end

	def get_month_production_data_by_site 
		#To get the production for site for a month 

		if params[:site].present? && params[:year].present? && params[:month].present?
			value = get_month_data("Energy Production")
			render json: { data: value}
		else
			render json: { message: "Required parameters are site name and year and month"}
		end
	end

	def get_week_production_data_by_site
		#To get the production for site for a week

		if params[:site].present? && params[:week_start_date]
			data = get_week_data("Energy Production")
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name and week start date"}
		end
	end

	def get_day_production_data_by_site
		#To get the production for site for a day

		if params[:site].present? && params[:date]
			data = get_day_data("Energy Production")
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name and date"}
		end
	end

	private

	def get_year_data(load_type)
		data = []
		query = "select sum(value) from power_readings_by_hour_new where year=#{params[:year]} and Site =~ /"+"#{params[:site]}" +"/ and LoadType = #{load_type} group by Month"
		result = $influxdb.query query
		result.each do |hash|
			month = hash["tags"]["Month"]
			value = hash["values"].first["sum"].present? ? (hash["values"].first["sum"]/1000).abs : 0
			data << {c: [{v: month}, {v: value}]}
		end
		return data
	end

	def get_demand_production()
		data = []
		query = "select sum(value) from power_readings_by_hour_new where year=#{params[:year]} and Site =~ /"+"#{params[:site]}" +"/ and LoadType = 'Demand' group by Month"
		demand_result = $influxdb.query query
		query = "select sum(value) from power_readings_by_hour_new where year=#{params[:year]} and Site =~ /"+"#{params[:site]}" +"/ and LoadType = 'Energy Production' group by Month"
		solar_result = $influxdb.query query
		demand_result.each_with_index do |hash, i|
			month = hash["tags"]["Month"]
			demand = hash["values"].first["sum"].present? ? (hash["values"].first["sum"]/1000).abs : 0
			solar = solar_result[i]["values"].first["sum"].present? ? (solar_result[i]["values"].first["sum"]/1000).abs : 0
			total_solar = total_solar + solar
			total_demand = total_demand + demand
			data << {c: [{v: month}, {v: demand}, {v: solar}]}
		end
		return data
	end

	def get_month_data(load_type)
		query = "select sum(power) from power_readings_by_hour where month=#{params[:month]} and year=#{params[:year]} and site =~ /"+"#{params[:site]}" +"/ and load_type = #{load_type}"
		result = $influxdb.query query
		value = result.empty? ? 0 : (result.first["values"].first["sum"]/1000).round
	end

	def get_week_data(load_type)
		start_time = params[:week_start_date].to_time.beginning_of_day
		end_time = start_time.end_of_day + 7.days
		query = "select sum(power) from power_readings_by_hour where time > #{start_time.strftime("%Y-%m-%d %H:%M:%S")} and time < #{end_time.strftime("%Y-%m-%d %H:%M:%S")} and site =~ /"+"#{params[:site]}" +"/ and load_type = #{load_type}"
		result = $influxdb.query query
	end

	def get_day_data(load_type, start_time, end_time)
		
		start_time = start_time.strftime("%Y-%m-%d %H:%M:%S")
		end_time = end_time.strftime("%Y-%m-%d %H:%M:%S")
		unless load_type == "Both"
			data = "Time,Load\n"
			query = "select value from #{$min_series} where time > '#{start_time}' and time < '#{end_time}' and Site = '#{params[:site]}' and LoadType = '#{load_type}'"
			result = $influxdb.query query
			values = result.first["values"]
			values.each do |hash|
				array = hash.values
				data << array[0].to_time.strftime("%Y/%m/%d %H:%M")+","
				data << array[1].to_s+"\n"
			end
		else
			query = "select value from #{$min_series} where time > '#{start_time}' and time < '#{end_time}' and Site = '#{params[:site]}' and (LoadType='Demand' or LoadType='Energy Production') group by LoadType"
			data = "Time,Demand,Energy Production\n"
			result = $influxdb.query query
			demand_values = result.first["values"]
			production_values = result.second["values"]
			demand_values.each_with_index do |hash, i|
				array = hash.values
				data << array[0].to_time.strftime("%Y/%m/%d %H:%M") + ","
				data << array[1].to_s + ","
				data << production_values[i]["value"].to_s + "\n"
			end
		end
		return data
	end

end
