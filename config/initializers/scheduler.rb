# this scheduler will run accordingly for every 50s , 1min, 1 hour , 1 day and so on.

=begin

=======
=begin
>>>>>>> d86438593f1679cf55465e07b4e0b20f080b3b61
require 'rufus-scheduler'
require 'active_record'

plugins = Dir.entries("#{Rails.root}/plugins/")
plugins.shift(2)
plugins.each do|plugin_dir|
  require "#{Rails.root}/plugins/#{plugin_dir}/config/initializers/scheduler" #if File.exists?("#{Rails.root}/plugins/#{plugin_dir}/config/initializers/scheduler") 
end

s = Rufus::Scheduler.singleton


#minute worker
s.every '50s' do # Run for every 50 secs
	puts "------------------------------------------------"
	puts Account.all.map(&:company_reference)
	puts "------------------------------------------------"
	Account.all.each do |account|
		Panel.all.each do|row|
			re_channels = row.circuits.where(is_producing: 1).map(&:channel_no)
			site = row.site
			MinWorker.perform_async("enos_#{account.company_reference}", site.site_ref, row.emon_url, site.location.postal_code.tz, re_channels)
		end
	end
end

#weather worker
s.every '50s' do   # 0, 15, 30 which means it will run for every 15 mins interval
  Account.all.each do|account|	
  	#raise account.company_reference.inspect	
  	#WeatherWorker.perform_async(account.company_reference)  #ToDo Uncomment this later 
  end 	
end

#hour worker
s.cron '14,29,44,59 * * * *' do # For every 15th min of an hour 
  Account.all.each do|account|	
	  Panel.all.each do|row|
	    HourWorker.perform_async(row.id, account.company_reference)
	  end
  end	
end


s.every '5m' do
  Panel.all.each do|row|
    LivedataWorker.perform_async(row.id)
  end
end

require 'rufus-scheduler'
require 'active_record'
require 'influxdb'

s = Rufus::Scheduler.singleton

$influxdb = InfluxDB::Client.new 'open_enos'

s.every '60s' do
	$inf
end

=end

