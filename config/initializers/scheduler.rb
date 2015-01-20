# this schedular will run accordingly for every 50s , 1min, 1 hour , 1 day and so on.
require 'rufus-scheduler'
require 'active_record'


s = Rufus::Scheduler.singleton

s.cron '0,15,30,45 * * * *' do  # 0, 15, 30 which means it will run for every 15 mins interval
  Account.all.each do|account|	
  	#raise account.company_reference.inspect	
  	#WeatherWorker.perform_async(account.company_reference)
  end 	
end

s.cron '5 * * * *' do
  Account.all.each do|account|	
	Panel.all.each do|row|
	  HourWorker.perform_async(row.id, account.company_reference)
	end
  end	
end