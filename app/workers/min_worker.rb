##
#Class' description
#MinWorker class performs all actions related to every minute updates on the cassandra keyspace tables
#@author::          Kishore Seemala
#@usage::           This class performs an action which will update emon_min_by_data table every minute

require "rexml/document"
require 'redis'
class MinWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(keyspace, panel, uri, time_zone, re_channels)
  @channel=[]
	@avg_power=0
	@input=0
	@flag=0
	isPowerProduced = re_channels.length>0? true: false
	powerProduced = 0
  redis = Redis.new
	puts "#{Time.now}: #{panel} Start"
  puts "keyspace: #{keyspace}"
	  	
	begin
		response = RestClient.get uri #get the response(data) from emon xml url
	  doc = REXML::Document.new(response.to_str)
	  cluster = Cassandra.cluster
		session  = cluster.connect(keyspace.downcase)
		time = (Time.now.utc.to_i/60)*60 #utc time
		time_of_current_zone = time + Time.zone_offset(time_zone).to_i #time zone location time
		@totalPowerValue = 0

			#loop xml response and capture data
		doc.elements.each("emonitor/channels/channel") do |channel|

    channel_no = channel.attributes["Number"] 
    value = channel.elements["avg_power"].text.to_i
    value = 0 if value<0 || value > 100000

		if channel.elements["paired_with_channel"].text.to_i !=0
      @channel << channel_no
      @avg_power = @avg_power + value 												#channel.elements["avg_power"].text.to_i
      @avg_power = 0 if @avg_power < 0 || @avg_power > 36000
      @input += channel.elements["input"].text.to_i
      @flag = 1
    elsif channel.elements["paired_with_channel"].text.to_i ==0
      @channel=[]
      @avg_power=0  
      @input=0
      @flag = 0
    end

    if @flag==1 && @channel.count==2
      
      all_channels = @channel.join(",").to_s
      powerProduced = powerProduced + @avg_power if re_channels.include?(all_channels)
      @totalPowerValue += @avg_power if @input==2
      session.execute("INSERT INTO emon_min_by_data(panel, channel, asof_min, value) VALUES ('#{panel}', 'CH-#{all_channels}', #{time}, #{@avg_power})")
      #session.execute("update emon_live_data set avg_power=#{@avg_power} where panel='#{panel}' and channel='CH-#{all_channels}'")
      redis.hset("panel-#{panel}-CH-#{all_channels}", "avg_power", @avg_power)
    end

    if @flag==0 
      
      powerProduced = powerProduced + value  if re_channels.include?(channel_no)
      @totalPowerValue += value if channel.elements["input"].text.to_i == 1
      session.execute("INSERT INTO emon_min_by_data(panel, channel, asof_min, value) VALUES ('#{panel}', 'CH-#{channel_no}', #{time}, #{value})") 
      #session.execute("update emon_live_data set avg_power=#{value} where panel='#{panel}' and channel='CH-#{channel_no}'")
      redis.hset("panel-#{panel}-CH-#{channel_no}", "avg_power", @avg_power)
    end

	end

	panelId = Site.find_by_site_ref(panel).panels.map(&:id)
  @totalPowerValue = 0 if !Circuit.where(panel_id: panelId, display: "Main Power").present?
  session.execute("INSERT INTO emon_min_by_data(panel, channel, asof_min, value) VALUES ('#{panel}', 'totalPower', #{time}, #{@totalPowerValue})")
  #session.execute("update emon_live_data set avg_power=#{@totalPowerValue} where panel='#{panel}' and channel='totalPower'")
  session.execute("INSERT INTO min_by_power_produced(site_ref, asof_min, value) VALUES ('#{panel}', #{time.to_i}, #{powerProduced})") if isPowerProduced == true
  redis.hset("panel-#{panel}-totalPower", "avg_power", @totalPowerValue)
  
    

  rescue Exception => e
  	puts e.message 
    puts "Fecthing data from emon_url for #{panel} is failed"
  end

	puts "#{Time.now}: #{panel} End"
	session.close
  end
end