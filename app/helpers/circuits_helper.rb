require 'csv'
require 'influxdb'

module CircuitsHelper

$influxdb = InfluxDB::Client.new 'open_enos'

$channel=[]
$total_power=0
$flag=0

	def get_data(site, csv)
		flag = 0
		value = 0
	  site = Site.find(site)
  	site_display = site.display
  	site_groups = site.site_groups.map(&:display).join(';')
  	circuits = site.panels.map(&:circuits).flatten
   	CSV.foreach(File.path(csv)) do |row|
   		if row[0] == "Date/Time"
   		else
	   		j = 1
	   		$total_power = 0
	   		if row[0] == 0
	   		 	$timestamp = row[0].to_time.to_i
	   		else	
		   		circuits.each_with_index do |circuit, i|
		   			value = row[j]
		   			if circuit.double_ct
		   				j += 1
		   				value = value + row[j]
		   			end
		   			if circuit.input 
		   				$total_power = $total_power + value.to_i
		   			end
		   			$influxdb.write_point('power_by_min', { values: { power: $total_power }, tags: { site: site_display, site_group: site_groups, elec_load_type: circuit.elec_load_type_id, circuit: circuit.display },  timestamp: $timestamp })
		   			j = j + 1	
		   		end
		 		end	
	  		$influxdb.write_point('power_by_min', { values: { power: $total_power }, tags: { site: site_display, site_group: site_groups, elec_load_type: "Demand", circuit: "Total Power" },  timestamp: $timestamp })
	  	end
	  end
	end
	  
end

