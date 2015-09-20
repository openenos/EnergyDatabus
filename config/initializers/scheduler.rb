require 'rufus-scheduler'
require 'active_record'

s = Rufus::Scheduler.singleton

s.every '60s' do
	Panel.all.each do|row|
		EmonWorker.perform_async(row.id)
	end
end

s.cron '0,15,30,45 * * * *' do
    PostalCode.all.each do|row|
		WeatherWorker.perform_async(row.weather_ref)
	end
end