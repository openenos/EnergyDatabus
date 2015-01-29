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
end
