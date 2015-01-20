require 'rufus-scheduler'
require 'active_record'


s = Rufus::Scheduler.singleton

s.every '50s' do
	Account.all.each do |account|
		Panel.all.each do|row|
			re_channels = row.circuits.where(is_producing: 1).map(&:channel_no)
			site = row.site
			MinWorker.perform_async("enos_#{account.company_reference}", site.site_ref, row.emon_url, site.location.postal_code.tz, re_channels)
		end
	end
end