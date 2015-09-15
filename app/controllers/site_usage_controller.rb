class SiteUsageController < ApplicationController

  include ApplicationHelper
 
  layout 'dashboard'
  
  def index
     @site = Site.find_by_display(params[:site])
     @site = Site.first unless @site.present?
  end

  def getSiteBySiteRef site_ref
    url = "#{getBaseURL}ws/getSiteBySiteRef.json?site_ref=#{site_ref}"
    url = URI.escape(url)
    jsonResponse url
  end

  def getDayJsonReport
    url = "#{getBaseURL}ws/dayDataBySite.json?site_ref=#{params[:site_ref]}&date=#{params[:date]}"
    url = URI.escape(url)
    json_data = jsonResponse url
    json_data["date"] = params[:date]
    respond_to do |format|
        format.json { render :json => json_data }
    end
  end
  
  def getWeekJsonReport
    url = "#{getBaseURL}ws/weekDataBySite.json?site_ref=#{params[:site_ref]}&date=#{params[:date]}"
    url = URI.escape(url)
    json_data = jsonResponse url
    respond_to do |format|
        format.json { render :json => json_data }
    end
  end
  
  def getMonthJsonReport
    url = "#{getBaseURL}ws/monthDataBySite.json?site_ref=#{params[:site_ref]}&date=#{params[:date]}"
    url = URI.escape(url)
    json_data = jsonResponse url
    respond_to do |format|
        format.json { render :json => json_data }
    end
  end

  def getDayWeekMonthYearJsonReport
  case params[:fetchdata]
    when "usage"
      case params[:type]
        when "day"
          date = params[:date].to_datetime + params[:days].to_i.day
          url = "#{getBaseURL}ws/dayDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
          url = URI.escape(url)
          jsonData = jsonResponse url
          json_data_array1 = jsonData["data"]
          site_name = jsonData["site_name"]
          url = "#{getBaseURL}ws/prevdayDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
          url = URI.escape(url)
          json_data_array2 = jsonResponse url
          json_data = {:site_name=>site_name, :data=>[json_data_array1, json_data_array2]}
          json_data["date"] = date.strftime("%d %B, %Y")
        when "week"
          date = params[:date].to_datetime + ((params[:days].to_i)*7).day
          url = "#{getBaseURL}ws/weekDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}"
          url = URI.escape(url)
          json_data = jsonResponse url
          json_data["date"] = date.strftime("%d %B, %Y")
          json_data["l_date"] = (params[:date].to_datetime + ((params[:days].to_i - 1)*7).day ).strftime("%d %B, %Y")
        when "month"
          date = params[:date].to_datetime + params[:days].to_i.month
          url = "#{getBaseURL}ws/monthDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}"
          url = URI.escape(url)
          json_data = jsonResponse url
          json_data["date"] = date.strftime("%B")
          json_data["l_date"] = params[:date].to_datetime.strftime("%B")
        when "year"
          date = params[:date].to_datetime + params[:days].to_i.year
          url = "#{getBaseURL}ws/yearDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}"
          url = URI.escape(url)
          json_data = jsonResponse url
          json_data["date"] = date.strftime("%Y")
          json_data["l_date"] = params[:date].to_datetime.strftime("%Y")
        end
    when "production"
      case params[:type]
      when "day"
        date = params[:date].to_datetime + params[:days].to_i.day
        url = "#{getBaseURL}ws/dayDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array1 = jsonData["data"]
        site_name = jsonData["site_name"]
        url = "#{getBaseURL}ws/prevdayDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
        url = URI.escape(url)
        json_data_array2 = jsonResponse url
        json_data = {:site_name=>site_name, :data=>[json_data_array1, json_data_array2]}
        json_data["date"] = date.strftime("%d %B, %Y")
      when "week"
        date = params[:date].to_datetime + ((params[:days].to_i)*7).day
        url = "#{getBaseURL}ws/weekDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        json_data = jsonResponse url
        json_data["date"] = date.strftime("%d %B, %Y")
        json_data["l_date"] = (params[:date].to_datetime + ((params[:days].to_i - 1)*7).day ).strftime("%d %B, %Y")
      when "month"
        date = params[:date].to_datetime + params[:days].to_i.month
        url = "#{getBaseURL}ws/monthDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        json_data = jsonResponse url
        json_data["date"] = date.strftime("%B")
        json_data["l_date"] = params[:date].to_datetime.strftime("%B")
      when "year"
        url = "#{getBaseURL}ws/dayDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{params[:date]}"
        url = URI.escape(url)
        json_data = jsonResponse url
        json_data["date"] = params[:date]
        json_data["date"] = ( params[:date].to_datetime + params[:days].to_i.year ).strftime("%Y")
        json_data["l_date"] = Time.now.strftime("%Y")
      end 
    when "both"
      case params[:type]
      when "day"
        date = params[:date].to_datetime + params[:days].to_i.day
        url = "#{getBaseURL}ws/dayDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array1 = jsonData["data"]
        site_name = jsonData["site_name"]

        url = "#{getBaseURL}ws/prevdayDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array2 = jsonData
        
        url = "#{getBaseURL}ws/dayDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array3 = jsonData["data"]
        
        url = "#{getBaseURL}ws/prevdayDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}&offset=#{params[:offset]}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array4 = jsonData
        
        json_data = {:site_name=>site_name, :data=>[json_data_array1, json_data_array2, json_data_array3, json_data_array4]}
        
        json_data["date"] = date.strftime("%d %B, %Y")
      when "week"
        date = params[:date].to_datetime + ((params[:days].to_i)*7).day
        url = "#{getBaseURL}ws/weekDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array1 = jsonData["data"]
        site_name = jsonData["site_name"]
        
        url = "#{getBaseURL}ws/weekDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array2 = jsonData["data"]
        
        json_data = {:site_name=>site_name, :data=>[json_data_array1, json_data_array2]}
        json_data["date"] = date.strftime("%d %B, %Y")
        json_data["l_date"] = (params[:date].to_datetime + ((params[:days].to_i - 1)*7).day ).strftime("%d %B, %Y")
      when "month"
        date = params[:date].to_datetime + params[:days].to_i.month
        url = "#{getBaseURL}ws/monthDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array1 = jsonData["data"]
        site_name = jsonData["site_name"]
        
        url = "#{getBaseURL}ws/monthDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        jsonData = jsonResponse url
        json_data_array2 = jsonData["data"]
        
        json_data = {:site_name=>site_name, :data=>[json_data_array1, json_data_array2]}
        
        json_data["date"] = date.strftime("%B")
        json_data["l_date"] = params[:date].to_datetime.strftime("%B")
      when "year"
        url = "#{getBaseURL}ws/dayDataBySiteProduction.json?site_ref=#{params[:site_ref]}&date=#{params[:date]}"
        url = URI.escape(url)
        json_data = jsonResponse url
        json_data["date"] = params[:date]
        json_data["date"] = ( params[:date].to_datetime + params[:days].to_i.year ).strftime("%Y")
        json_data["l_date"] = Time.now.strftime("%Y")
      end 
    end

    respond_to do |format|
        format.json { render :json => json_data }
    end
  end
  
  def getpastDayJsonReport
        date = params[:date].to_datetime + (params[:days].to_i - 1).day
        url = "#{getBaseURL}ws/dayDataBySite.json?site_ref=#{params[:site_ref]}&date=#{date}"
        url = URI.escape(url)
        json_data = jsonResponse url
        json_data["date"] = date.strftime("%d %B, %Y")
    respond_to do |format|
        format.json { render :json => json_data }
    end
  end
  
  def hasProductionData
    url = "#{getBaseURL}ws/isSiteHasProductionData.json?site_ref=#{params[:site_ref]}"
    url = URI.escape(url)
    json_data = jsonResponse url
    respond_to do |format|
        format.json { render :json => json_data }
    end
  end
  
end
