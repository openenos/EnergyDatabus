require 'rufus-scheduler'
require 'active_record'

s = Rufus::Scheduler.singleton

s.every '60s' do
	   Panel.all.each do|row|
			EmonWorker.perform_async(row.id)
	   end
end