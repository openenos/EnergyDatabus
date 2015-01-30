class Ws::SitesController < ApplicationController
  
  def get_live_data_by_site
  	
  	redis = Redis.new
    site_data_json = {}
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
	    
	    #if Circuit.where(panel_id: site.id, dis: "Main Power").present?
	    
	    #Circuit.where(panel_id: site.id, input: 1, active: 1).each do|circuit|

	      #results = db.execute("select * from emon_live_data where panel='#{site.site_ref}' and channel='totalPower' ALLOW FILTERING")
		  results = redis.hget("panel-#{site.site_ref}-totalPower", "avg_power")
	      #raise results.inspect
	      results.each do|result|
	        values = {avg_power: result['avg_power']/1000.0, max_power: result['max_power']/1000.0, total_power: result['total_power']}
	        site_data_json = site_data_json.merge(values)
	        #site_data_json[circuit.dis.to_s] = values
	      end
	      #end
	    #end
	   	end
	 
	  end
	 
	  respond_to do |format|
	    format.json { render :json => site_data_json }
	  end
 
  end
  
end
