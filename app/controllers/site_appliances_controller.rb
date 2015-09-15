class SiteAppliancesController < ApplicationController

  include ApplicationHelper
  
  layout 'dashboard'
  
  def index
    @site = Site.find_by_display(params[:site])
  end
  
  def getAllchannelsData
    @getAllChannelsBySiteRef = getAllChannelsBySiteRef params[:site_ref]
    @json_data = []
    @getAllChannelsBySiteRef.each do|channel|
       url = "#{getBaseURL}ws/dayDataBySiteAndChannel.json?site_ref=#{params[:site_ref]}&channel=#{channel}"
       url = URI.escape(url)
       res = jsonResponse url
       @json_data << res
    end
    respond_to do |format|
      format.json { render :json => @json_data unless @json_data.nil? }
    end 
  end
  
  def getAllChannelsBySiteRef site_ref
    url = "#{getBaseURL}ws/getAllChannelsBySiteRef.json?site_ref=#{site_ref}"
    url = URI.escape(url)
    res = jsonResponse url
  end
  
  def getSiteBySiteRef site_ref
    url = "#{getBaseURL}ws/getSiteBySiteRef.json?site_ref=#{site_ref}"
    url = URI.escape(url)
    jsonResponse url
  end
  
end
