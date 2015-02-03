require 'redis'
class LivedataWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(panelId)
    redis = Redis.new
   #db = CassandraCQL::Database.new('127.0.0.1:9160', {:keyspace => "enos_hgv"})
    db = cassandraDbConnection
    Circuit.where(:panel_id=>panelId).each do|circuit|
      total_power = 0
      panel = circuit.panel.site.site_ref

      live_result = db.execute("select * from emon_min_by_data where panel='#{circuit.panel.site.site_ref}' and channel='CH-#{circuit.channel_no}' and asof_min>=#{Time.now.utc.beginning_of_day.to_i} and asof_min<=#{Time.now.utc.end_of_day.to_i} ALLOW FILTERING")
      values = live_result.map { |n| n['value'] }
      value = 0
      value = values.max unless values.empty?
      total_power = ((values.sum)/values.length)/1000  unless values.empty?
      #db.execute("update emon_live_data set max_power=#{value}, total_power=#{total_power} where panel='#{circuit.panel.site.site_ref}' and channel='CH-#{circuit.channel_no}'")
      redis.hmset("panel-#{panel}-CH-#{circuit.channel_no}", "max_power", value, "total_power", total_power)
    end
    totalPowerValue = 0
    site_ref = Panel.find(panelId).site.site_ref
    live_power_result = db.execute("select * from emon_min_by_data where panel='#{site_ref}' and channel='totalPower' and asof_min>=#{Time.now.utc.beginning_of_day.to_i} and asof_min<=#{Time.now.utc.end_of_day.to_i} ALLOW FILTERING")
    live_values = live_power_result.map { |n| n['value'] }
    live_value = 0
    live_value = live_values.max unless live_values.empty?
    totalPowerValue = ((live_values.sum)/live_values.length)/1000  unless live_values.empty?
    #db.execute("update emon_live_data set max_power=#{live_value}, total_power=#{totalPowerValue} where panel='#{site_ref}' and channel='totalPower'")
    redis.hmset("panel-#{panel}-totalPower", "max_power", value, "total_power", total_power)   
  end


  private

  def cassandraDbConnection
    cluster = Cassandra.cluster
    session  = cluster.connect("enos_sample")
  end
  
end