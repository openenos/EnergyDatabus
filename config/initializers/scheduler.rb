# this scheduler will run accordingly for every 50s , 1min, 1 hour , 1 day and so on.

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
	Account.all.each do |account|
		Panel.all.each do|row|
			re_channels = row.circuits.where(is_producing: 1).map(&:channel_no)
			site = row.site
			MinWorker.perform_async("enos_#{account.company_reference}", site.site_ref, row.emon_url, site.location.postal_code.tz, re_channels)
		end
	end
end

#weather worker
s.cron '0,15,30,45 * * * *' do  # 0, 15, 30 which means it will run for every 15 mins interval
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