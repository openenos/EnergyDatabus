require 'influxdb'
require "rexml/document"

class EmonWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(panelId)
  
    @channel=[]
    @avg_power=0
    @flag=0
	@data=[]
	
	#host = "54.203.254.118"
  host = "localhost"
	username = 'enos'
  password = 'p@ssw0rd'
  database = 'openenos'
  series     = 'power_readings_new'
	time_precision = 'm'
  
  panel = Panel.find(panelId)
	site = panel.site
	site_name = site.display
	site_group = ""
	site.site_groups.each do|group|
		site_group.concat(group.display)
		site_group.concat(";")
	end
	
	time_zone = site.location.postal_code.tz
	uri = panel.emon_url
	
	cts = Hash.new()
	loads = Hash.new()
  
	Circuit.where(:panel_id=>panelId).each do|ct|
	    cts[ct.channel_no] = ct.display
		loads[ct.channel_no] = ct.elec_load_type.display
	end
	
	
	begin    
      #puts "#{Time.now}: #{panel} #{uri}*************\n"        
      response = RestClient.get uri
      #puts "#{Time.now}: #{panel} 1"
      doc = REXML::Document.new(response.to_str)
	  
	  influxdb = InfluxDB::Client.new database, host: host, username: username, password: password, time_precision: time_precision

      #time = (Time.now.utc.to_i/60)*60 #utc time
      #time_of_current_zone = time + Time.zone_offset(time_zone).to_i #time zone location time
	  #time_of_current_zone = time_of_current_zone*1000

      time = Time.now
      mon = time.strftime("%b")
      year = time.strftime("%Y")
      @totalPowerValue = 0
      #puts "#{Time.now}: #{panel} 2"
      doc.elements.each("emonitor/channels/channel") do |channel|

              channel_no = channel.attributes["Number"] 

              value = channel.elements["avg_power"].text.to_i
              value = 0 if value<0 || value > 100000
			  
			  if channel.elements["paired_with_channel"].text.to_i !=0
                @channel << channel_no
                @avg_power = @avg_power + channel.elements["avg_power"].text.to_i
                @avg_power = 0 if @avg_power < 0 || @avg_power > 36000
                @flag = 1
              elsif channel.elements["paired_with_channel"].text.to_i ==0
                @channel=[]
                @avg_power=0  
                @flag = 0
              end

              if @flag==1 && @channel.count==2
              all_channels=@channel.join(",").to_s

              @totalPowerValue += @avg_power if channel.elements["input"].text.to_i == 1
			  puts "#{loads[all_channels]} : #{cts[all_channels]} : #{@avg_power}"
			  
			  @data << {
			        series: series,
                    values: { value: @avg_power },
                    tags: { Year: year, Month: mon, SiteGroup: site_group, Site: site_name, LoadType: loads[all_channels], Circuit: cts[all_channels]}
                  }
              #influxdb.write_point(name, data)
			  
              end

              if @flag==0 
              @totalPowerValue += value if channel.elements["input"].text.to_i == 1
              puts "#{loads[channel_no]} : #{cts[channel_no]} : #{value}"
			  loadType = loads[channel_no]
			  circuit = cts[channel_no]
			  if !loadType.nil?
				  @data << {
						series: series,
						values: { value: value },
						tags: { Year: year, Month: mon, SiteGroup: site_group, Site: site_name, LoadType: loadType, Circuit: circuit}
					  }
			   end
              #influxdb.write_point(name, data)

              end
      end
	  @data << {
			series: series,
            values: { value: @totalPowerValue },
            tags: { Year: year, Month: mon, SiteGroup: site_group, Site: site_name, LoadType: 'Demand', Circuit: 'Total Power'}
        }
	  influxdb.write_points(@data)
        rescue   Exception => e  
          puts e.message 
          puts "Fecthing data from emon_url for #{panel.site.display} is failed"
        end  
  end
end