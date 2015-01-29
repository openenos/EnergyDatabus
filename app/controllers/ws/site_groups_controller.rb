class Ws::SiteGroupsController < ApplicationController
	def current_demand_by_group
    site_data_json = {}
    params[:group_id] ||= SiteGroup.first.id
    site_data_json[:group_id] = params[:group_id]
    site_data_json[:demand_sum] = sum_of_demand_avg_values params[:group_id]
    render :json =>  site_data_json
  end
  
  def solar_power_by_group
    site_data_json = {}
    params[:group_id] ||= SiteGroup.first.id
    site_data_json[:group_id] = params[:group_id]
    site_data_json[:solar_sum] = sum_of_solar_avg_values params[:group_id]
    render :json =>  site_data_json
  end
  
  def utilityPower
    params[:group_id] ||= SiteGroup.first.id
    site_data_json = {}
    utility_power = ((sum_of_demand_avg_values params[:group_id]) - (sum_of_solar_avg_values params[:group_id])) 
    if utility_power >=0
      site_data_json[:utility_flag] =  true
    else
      site_data_json[:utility_flag] =  false
    end
    
    site_data_json[:group_id] = params[:group_id]
    site_data_json[:utility_power] = utility_power.abs
    render :json =>  site_data_json
  end

  private

  def sum_of_demand_avg_values 
  	redis = Redis.new
  	group_id = params[:group_id]
    #db = get_cassandra_connection
    sites = SiteGroup.find(group_id).sites
    demand_sum = 0
    sites.each do|site|
      #if Circuit.where(panel_id: site.id, dis: "Main Power").present?
    	site.panels.each do |panel|
      	panel.circuits.where(display: "Main Power", active: 1).each do|circuit|
      		#results = db.execute("select * from emon_live_data where panel='#{site.site_ref}' and channel='CH-#{circuit.channel_no}' ALLOW FILTERING")
      		#results.each do|result|
        	#demand_sum = demand_sum + result['avg_power'].to_i
      		#end
      		result = redis.hget("panel-#{site.site_ref}-CH-#{circuit.channel_no}", "avg_power")
      		demand_sum = demand_sum + result.to_i
      	end
    		#end
    	end
    end
    return demand_sum/1000
  end

  def sum_of_solar_avg_values
  	redis = Redis.new
  	db = get_cassandra_connection
  	solar_sum = 0
  	group_id = params[:group_id]
  	sites = SiteGroup.find(group_id).sites
  	sites.each do|site|
  		results = db.execute("select * from min_by_power_produced where site_ref='#{site.site_ref}' and asof_min>=#{(Time.now-3.minute).to_i} limit 1")
  		results.each do|result|
        solar_sum = solar_sum + result['value'].to_i
      end
    end
    return solar_sum/1000
  end

  def get_cassandra_connection
  	cluster = Cassandra.cluster
		session  = cluster.connect("enos_sample")
  end
end
