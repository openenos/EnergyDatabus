class Api::SiteUsageController < ApplicationController
	$influxdb = InfluxDB::Client.new "openenos"
	
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

		if params[:site].present? && params[:week_start_date]
			data = get_week_data("Demand")
			render json: { data: value }
		else
			render json: { message: "Required parameters are site name and week start date"}
		end
	end

	def get_day_usage_data_by_site
		#To get the usage for site for a day

		if params[:site].present? && params[:date]
			data = get_day_data("Demand")
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
		(1..12).to_a.each do |month|
			query = "select sum(power) from power_readings_by_hour where month=#{month} and year=#{params[:year]} and site =~ /"+"#{params[:site]}" +"/ and load_type = #{load_type}"
			result = $influxdb.query query
			value = result.empty? ? 0 : (result.first["values"].first["sum"]/1000).round
			data << [month, value]
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

	def get_day_data(load_type)
		data = []
		start_time = params[:date].to_time.beginning_of_day
		end_time = start_time.end_of_day
		query = "select power from power_readings_by_min where time > '#{start_time.strftime("%Y-%m-%d %H:%M:%S")}' and time < '#{end_time.strftime("%Y-%m-%d %H:%M:%S")}' and site =~ /"+"#{params[:site]}" +"/ and load_type = #{load_type}"
		result = $influxdb.query query
		result.each do |hash|
			values = hash["values"]
			values.each do |value|
				data << value.values
			end
		end
	end

end
