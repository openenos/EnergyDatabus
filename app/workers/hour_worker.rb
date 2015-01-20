#
# Description 

#Hourly Worker

#author : Sridhar Vedula
#This worker updates records in cassandra database for every hour 

class HourWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
   
  def perform(panelId, name)
    isPowerProduced = false
    powerProduced = 0
    time=(Time.now.utc - 1.hour).beginning_of_hour.to_i
    site_ref = Panel.find(panelId).site.site_ref
    cluster = Cassandra.cluster
    session  = cluster.connect()
    session.execute("USE enos_#{name}")
    @totalPowerValue = 0
    Circuit.where(:panel_id=>panelId, :active=>1).each do|circuit|
      sum=0
      sum_not_zero_values=0
      no_min=0
       result = session.execute("select * from emon_min_by_data where panel=\'#{site_ref}\' and channel=\'CH-#{circuit.channel_no}\' and asof_min>=#{time} and asof_min<#{(Time.now.utc.beginning_of_hour).to_i} ALLOW FILTERING")
        result.each do|row|
          sum = row['value'].to_i+sum
          sum_not_zero_values = sum_not_zero_values + 1 unless row['value'].to_i==0
          no_min += 1
        end
      
        sum = sum/no_min unless sum==0
        sum = sum.round
        
        @totalPowerValue += sum if circuit.input
      
        if circuit.is_producing == 1
          powerProduced =  sum + powerProduced
          isPowerProduced = true
        end  
      session.execute("INSERT INTO emon_hourly_data(panel, channel, asof_hr, value) VALUES ('#{site_ref}', 'CH-#{circuit.channel_no}', #{time}, #{sum})")
      session.execute("INSERT INTO emon_hourly_runtime(panel, channel, asof_hr, value) VALUES ('#{site_ref}', 'CH-#{circuit.channel_no}', #{time}, #{sum_not_zero_values})")
    end
     
     @totalPowerValue = 0 if !Circuit.where(panel_id: panelId, display: "Main Power").present?
     session.execute("INSERT INTO emon_hourly_data(panel, channel, asof_hr, value) VALUES ('#{site_ref}', 'totalPower', #{time}, #{@totalPowerValue})")
     #session.execute("INSERT INTO hourly_power_produced(site_ref, asof_hr, value) VALUES ('#{site_ref}', #{time.to_i}, #{powerProduced})") if isPowerProduced == true

  end
end    