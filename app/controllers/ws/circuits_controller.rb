class Ws::CircuitsController < ApplicationController

  def get_current_demand_by_site
    redis = Redis.new
    if  params[:site_ref].nil?
      site_data_json = {"Error" => "Required Parameters: #{'site_ref' if params[:site_ref].nil?}"}
    elsif params[:site_ref].empty?
      site_data_json = {"Error" => "Value Required for: #{'site_ref' if params[:site_ref].empty?}"}
    else
    
    site_ref = params[:site_ref]
    
    if Site.find_by_site_ref(params[:site_ref]).nil?  
      site_data_json = {"Error" => "Record not found with Site Reference #{params[:site_ref]}"}
    else 
    
    site = Site.find_by_site_ref(site_ref)
    
    site_data_json = {site_name: site.display}

    db = cassandraDbConnection

    channel_data = {}
    circuit_info = {}
    Circuit.where(panel_id: site.id, input: 0, active: 1).each do|circuit|
    	circuit_info[circuit.display] = circuit.id
	    results = redis.hget("panel-#{site.site_ref}-CH-#{circuit.channel_no}", "avg_power")	
	    results.each do |result|
	    	channel_data[circuit.display] = result['avg_power']
	    end
	  end
	    
    site_data_json[:circuits] = circuit_info
    site_data_json[:data] = Hash[channel_data.sort_by { |k,v| v }.reverse]
   end
   end
    respond_to do |format|
        format.json { render :json => site_data_json }
    end
  end

  def get_fivec_last_month
  	site_data_json = {}
    circuitData = {}
    channel_list = getAllNonInputChannelNamesBySite params[:site_ref]
    db = cassandraDbConnection
    if params[:site_ref].present?
    results = db.execute("select * from emon_daily_data where site_ref='#{params[:site_ref]}'")
      results.each do|result|
        circuitData[channel_list[result['channel']].to_s] = result['total_power'] if channel_list.has_key?(result['channel'].to_s)
      end
      circuitData.delete("Main Power")
      data = Hash[circuitData.sort_by { |k,v| v }.reverse].first 5
      site_data_json[:data] = data.to_h
    end
    respond_to do |format|
        format.json { render :json =>  site_data_json }
    end
  end

  private

  def cassandraDbConnection
  	cluster = Cassandra.cluster
    session  = cluster.connect("enos_sample")
  end


  def getAllNonInputChannelNamesBySite site_ref
    list_of_circuite = {}
    site = Site.find_by_site_ref(site_ref)
    
    if site_ref=="HGV10"
      Circuit.where(panel_id: site.id, re: 1).each do|circuit|
        list_of_circuite["CH-#{circuit.channel_no}"] = circuit.dis
      end
    else
      Circuit.where(panel_id: site.id, input: 0).each do|circuit|
        list_of_circuite["CH-#{circuit.channel_no}"] = circuit.dis
      end
    end
    
    return list_of_circuite
  end
   	
end
