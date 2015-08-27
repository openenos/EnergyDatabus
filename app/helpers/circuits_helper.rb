require 'csv'
require 'influxdb'

module CircuitsHelper

$influxdb = InfluxDB::Client.new 'openenos'

$total_power=0
$timestamp = 0

	def get_data(site, csv)
		value = 0
		$count = 0
		total_power=0
		$flag = 0
	  site = Site.find(site)
  	site_display = site.display
  	site_groups = site.site_groups.map(&:display).join(';')
  	circuits = site.panels.map(&:circuits).flatten
   	CSV.foreach(File.path(csv)) do |row|
   		if ($count > 5 )
	   		if row[0] == "Date/Time"
	   		else
		   		j = 1
		   		$total_power = 0
		   		if row[0] == 0
		   		 	timestamp = row[0].to_time.to_i
		   		else	
			   		circuits.each_with_index do |circuit, i|
			   			$value = row[j].to_i
			   			#puts "value: #{$value} - #{circuit.double_ct} - #{circuit.display}"
			   			if circuit.double_ct
			   				j += 1
			   				$value = $value + row[j].to_i
			   			end
			   			#puts "value: #{$value} - #{circuit.double_ct} - #{circuit.display}"
			   			#puts "_________________________"
			   			if circuit.input 
			   				$total_power = $total_power + $value.to_i
			   			end
			   			$influxdb.write_point('power_readings_by_min', { values: { power: $value }, tags: { site: site_display, site_group: site_groups, load_type: circuit.elec_load_type.display, circuit: circuit.display },  timestamp: row[0].to_time.to_i }) unless row[0].to_time.to_i == 0
			   			j = j + 1	
			   		end
			   		puts "_________________"
			 		end	
		  		$influxdb.write_point('power_readings_by_min', { values: { power: $total_power }, tags: { site: site_display, site_group: site_groups, load_type: "Demand", circuit: "Total Power" },  timestamp: row[0].to_time.to_i }) unless row[0].to_time.to_i == 0
		  	end
		  end
		  $count = $count + 1
	  end
	end
	  
end

