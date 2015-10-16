class HomeController < ApplicationController
  
	layout 'dashboard', :only => [:dashboard]

  def index
  end

  def dashboard
  	 from_date = (Time.now - 30.day).strftime("%d-%m-%Y")
      to_date = Time.now.strftime("%d-%m-%Y")
      from_date = params[:from] if params[:from].present?
      to_date = params[:to] if  params[:to].present?
      @days_between_dates = Date.parse(to_date).mjd - Date.parse(from_date).mjd
      @groups = Hash[SiteGroup.pluck(:id, :display)]
      if params[:group_id].present?
        groupId = params[:group_id]
      else
        #groupId = @groups.first['id']
      end
      @resp_data = []
      @site_group = SiteGroup.first
      @load_types = ElecLoadType.all.map(&:display)
  end

end
