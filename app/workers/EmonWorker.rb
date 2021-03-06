require 'influxdb'
require "rexml/document"

class EmonWorker
  include Sidekiq::Worker
  sidekiq_options :retry=>1

  #Getting influxdb object and series using influx db config file
  influxdb_config = YAML.load_file('config/influxdb_config.yml')
  $influxdb_config = influxdb_config[Rails.env]
  $database = $influxdb_config["database"]
  $username = $influxdb_config["username"]
  $password = $influxdb_config["password"]

  def perform(panelId)

    @channel=[]
    @avg_power=0
    @flag=0
    @data=[]
	runtimeData = []
	rowData = []
    rowValues = {}

    host = "localhost"
    username = $username
    password = $password
    database = $database
    series     = 'emon_readings'
	  runtime_series = 'appliance_runtimes'
    time_precision = 'm'

    panel = Panel.find(panelId)
    site = panel.site
    site_name = site.display
    site_group = site.site_groups.map(&:display).join(';')

    uri = panel.emon_url

    cts = Hash.new()
    loads = Hash.new()

    Circuit.where(:panel_id=>panelId).each do|ct|
      cts[ct.channel_no] = ct.display
      loads[ct.channel_no] = ct.elec_load_type.display
    end


    begin    
      puts "Fetching data from #{uri} for #{site_name} - Start"   
      response = RestClient.get uri
      doc = REXML::Document.new(response.to_str)

      influxdb = InfluxDB::Client.new database, host: host, username: username, password: password, time_precision: time_precision

      time = Time.now
      mon = time.strftime("%b")
      year = time.strftime("%Y")
      @totalPowerValue = 0
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
          #puts "#{loads[all_channels]} : #{cts[all_channels]} : #{@avg_power}"
          rowValues[cts[all_channels]]=@avg_power
          @data << {
            series: series,
            values: { value: @avg_power },
            tags: { Year: year, Month: mon, SiteGroup: site_group, Site: site_name, LoadType: loads[all_channels], Circuit: cts[all_channels]}
          }
		  running = @avg_power>0?1:0
		  runtimeData << {
            series: runtime_series,
            values: { value: running },
            tags: { Site: site_name, LoadType: loads[all_channels], Circuit: cts[all_channels]}
          }

        end

        if @flag==0 
          @totalPowerValue += value if channel.elements["input"].text.to_i == 1
          #puts "#{loads[channel_no]} : #{cts[channel_no]} : #{value}"
          loadType = loads[channel_no]
          circuit = cts[channel_no]
          if !loadType.nil?
            rowValues[circuit]=value
            @data << {
              series: series,
              values: { value: value },
              tags: { Year: year, Month: mon, SiteGroup: site_group, Site: site_name, LoadType: loadType, Circuit: circuit}
            }
			running = value>0?1:0
		    runtimeData << {
            series: runtime_series,
            values: { value: running },
            tags: { Site: site_name, LoadType: loadType, Circuit: circuit}
            }
          end
        end
      end

      if loads.has_value?('Mains')
        @data << {
          series: series,
          values: { value: @totalPowerValue },
          tags: { Year: year, Month: mon, SiteGroup: site_group, Site: site_name, LoadType: 'Demand', Circuit: 'Total Power'}
        }
      end

      influxdb.write_points(@data)
	  influxdb.write_points(runtimeData)

      rowData << {
        series: "emon_readings_table_#{site.id}",
        values: rowValues
      }
	  
      influxdb.write_points(rowData)
	  
      puts "Fetching data from #{uri} for #{site_name} - End"

    rescue   Exception => e   
      puts "Fetching data from #{uri} for #{site_name} - Failed"
      puts e.message
    end  
  end
end
