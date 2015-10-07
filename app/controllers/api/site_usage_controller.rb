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
				data = get_year_data(params["load_type"], params["year"])
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
		
		if params[:site].present? && params[:date].present?
			date = params["date"].to_date
			data = get_month_data(params["load_type"], date)
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name and year and month"}
		end
	end

	def get_week_usage_data_by_site
		#To get the usage for site for a week

		if params[:site].present? && params[:date].present?
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

		if params[:site].present? && params[:date].present?
			start_time = params["date"].to_date.to_time
			end_time = start_time.end_of_day
			data = get_day_data(params["load_type"], start_time, end_time)
			render json: { data: data }
		else
			render json: { message: "Required parameters are site name and date"}
		end
	end

	
	private

	def get_year_data(load_type, year)
		data = [["Day", "Load"]]
		unless load_type == "Both"
			query = "select sum(value) from #{$hr_series} where Year='#{year}' and Site = '#{params[:site]}' and LoadType = '#{load_type}' group by Month"
			result = $influxdb.query query
			result.reverse.each do |hash|
				data << [hash["tags"]["Month"], hash["values"].first["sum"].present? ? hash["values"].first["sum"].to_i/1000 : 0]
			end
		end
		return data
	end

	def get_month_data(load_type, date)
		month = date.strftime("%b")
		year = date.strftime("%Y")
		data = [["Day", "Load"]]
		unless load_type == "Both"
			query = "select sum(value) from #{$hr_series} where time > '#{date.to_time.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")}' and Month='#{month}' and Year= '#{year}' and Site = '#{params[:site]}' and LoadType = '#{load_type}' group by time(1d)"
			result = $influxdb.query query
			result.first["values"].each do |hash|
				values = hash.values
				data << [values[0].to_date.to_s, values[1].present? ? values[1].to_i/1000 : 0]
			end
		end
		return data
	end

	def get_week_data(load_type,start_time, end_time)
		start_time = start_time.strftime("%Y-%m-%d %H:%M:%S")
		end_time = end_time.strftime("%Y-%m-%d %H:%M:%S")
		unless load_type == "Both"
			data = "Time,Load\n"
			query = "select value from #{$hr_series} where time > '#{start_time}' and time < '#{end_time}' and Site = '#{params[:site]}' and LoadType = '#{load_type}'"
			result = $influxdb.query query
			values = result.first["values"]
			values.each do |hash|
				array = hash.values
				data << array[0].to_time.strftime("%Y/%m/%d %H:%M")+","
				data << array[1].to_s+"\n"
			end
		else
			query = "select value from #{$hr_series} where time > '#{start_time}' and time < '#{end_time}' and Site = '#{params[:site]}' and (LoadType='Demand' or LoadType='Energy Production') group by LoadType"
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
