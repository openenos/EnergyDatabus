class SiteSnapshotsController < ApplicationController

  include ApplicationHelper
  
  layout 'dashboard'
  
  def index
    @liveData = []
    @solarData = []
    @site = Site.find_by_display(params[:site])
    @site = Site.first unless @site.present?
  end
  
  def getWeatherReport site_ref
    url = "#{getBaseURL}ws/getWeather.json?site_ref=#{site_ref}"
    url = URI.escape(url)
    jsonResponse url
  end
  
  def getLiveDataBySite site_ref
    url = "#{getBaseURL}ws/getLiveDataBySite.json?site_ref=#{site_ref}"
    url = URI.escape(url)
    jsonResponse url
  end
  
  def getSolarDataBySite site_ref
    url = "#{getBaseURL}/ws/getSolarDataBySite.json?site_ref=#{site_ref}"
    url = URI.escape(url)
    jsonResponse url
  end
  
  def lastHoursDataBySite
    url = "#{getBaseURL}ws/lastHoursDataBySite.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
        format.json { render :json => res }
    end
  end
  
  def liveDataBySite
    url = "#{getBaseURL}ws/getLiveDataBySite.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
        format.json { render :json => res }
    end
  end
  
  def solarDataBySite
    url = "#{getBaseURL}/ws/getSolarDataBySite.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
        format.json { render :json => res }
    end
  end

  def currentDemandBySite
    url = "#{getBaseURL}ws/getCurrentDemandBySite.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
        format.json { render :json => res }
    end
  end
  
  def weatherReport
    url = "#{getBaseURL}ws/getWeather.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
        format.json { render :json => res }
    end
  end
  
  def last5Circuits30DaysData
    url = "#{getBaseURL}ws/last5Circuits30DaysData.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
        format.json { render :json => res }
    end
  end

  def allCircuits30DaysData
    url = "#{getBaseURL}ws/allCircuits30DaysData.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    res = jsonResponse url
    respond_to do |format|
      format.json { render :json => res }
    end
  end
  
end
