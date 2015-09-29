class AnalyticsController < ApplicationController
	layout "dashboard"

	def index
  	@site = Site.find_by_display(params[:site])
    @site = Site.first unless @site.present?

    influxdb_config = YAML.load_file('config/influxdb_config.yml')
		$influxdb_config = influxdb_config[Rails.env]
		$database = $influxdb_config["database"]
		$min_series = $influxdb_config["series"]["min_table"]
		$hr_series = $influxdb_config["series"]["hour_table"]
		$username = $influxdb_config["username"]
	  $password = $influxdb_config["password"]
	  $influxdb = InfluxDB::Client.new $database, username: $username, password: $password

	  #get the max of values for each day for a given site and find the average
	  query = "select max(value) from #{$min_series} where Site='#{@site.display}' and time > now() - 8d and LoadType='Demand' group by time(1d)"
	  result = $influxdb.query query
	  result = result.first["values"]
	  result.shift(1)
	  result.pop
	  sum = result.map { |hash| hash["max"] }.compact.inject(:+)
	  max_avg = sum/7
	  @max_avg_site = (max_avg/@site.area_gross_square_foot).round(2)

	  #get the average daily max
	  query = "select percentile(value, 95) from #{$min_series} where Site='#{@site.display}' and time > now() - 8d and LoadType='Demand' group by time(1d)"
	  result = $influxdb.query query
	  result = result.first["values"]
	  result.shift(1)
	  result.pop
	  sum = result.map { |hash| hash["percentile"] }.compact.inject(:+)/1000.0
	  @avg_daily_max = (sum/7).round(2)

	  #get the average daily max
	  query = "select percentile(value, 5) from #{$min_series} where Site='#{@site.display}' and time > now() - 8d and LoadType='Demand' group by time(1d)"
	  result = $influxdb.query query
	  result = result.first["values"]
	  result.shift(1)
	  result.pop
	  sum = result.map { |hash| hash["percentile"] }.compact.inject(:+)/1000.0
	  @avg_daily_min = (sum/7).round(2)

	  #get the range 95 percentile - 5 percentile for a site
	  @range = (@avg_daily_max - @avg_daily_min).round(2)

	  #get the base to peak load ratio
	  @ratio = (@avg_daily_min.to_f/@avg_daily_max).round(2)
	  

	  #get the load variability metric
	  start_date = Date.today - 7.days
		start_time = start_date.to_time.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S")
		end_date = Date.today - 1.days
		end_time = end_date.to_time.end_of_day.strftime("%Y-%m-%d %H:%M:%S")
	  query = "select mean(value) from #{$hr_series} where Site='#{@site.display}' and LoadType='Demand' and time > '#{start_time}' and time < '#{end_time}' group by time(1h)"
	  
	  #creating 24 buckets for 24 hrs
	  bucket = []
	  (0..23).to_a.each do |num|
	  	bucket[num] = []
	  end

	  result = $influxdb.query query
	  result = result.first["values"]
	  index = 0
	  result.each do |hash|
	  	if index == 24
	  		index = 0
	  	end
	  	bucket[index] << (hash["mean"].present? ? hash["mean"] : 0)

	  	index = index + 1
	  end
	  mean_bucket = []
	  bucket.each_with_index do |array, index|
	  	stats = DescriptiveStatistics::Stats.new(array)
	  	std_deviation = stats.standard_deviation
	  	mean = stats.mean
	  	mean_bucket[index] = mean == 0 ? 0 : std_deviation/mean
	  end
	  
	  @load_variable_metric = (mean_bucket.sum/mean_bucket.count).round(2)
  end
end
