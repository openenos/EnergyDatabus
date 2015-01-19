require 'open-uri'

class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]

   before_filter :valid_site_check, only: [:getWeather, :getLiveDataBySite]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @site }
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getWeather
    
    
    #raise params.inspect

    json_data = {}
    
    if params[:weather_ref].present?
    api_key = "87e74b8d9511ea00"
    w_api = Wunderground.new(api_key)
  
    
    result = w_api.conditions_for("pws:#{weather_ref.to_s}")
    #country = result['current_observation']['observation_location']['country']
    #city = result['current_observation']['observation_location']['city']
    
      unless result['current_observation'].nil?
        image = result['current_observation']['icon_url']
        status = result['current_observation']['weather']
        temp_f = result['current_observation']['temp_f']
        wind_string = "From the #{result['current_observation']['wind_dir']} at #{result['current_observation']['wind_mph']} MPH"
        relative_humidity = result['current_observation']['relative_humidity']
        
        json_data = {image: image, status: status, temp_f: temp_f, wind_string: wind_string, relative_humidity: relative_humidity}
        
        forecast = JSON.load(open("http://api.wunderground.com/api/#{api_key}/forecast/q/pws:#{weather_ref.to_s}.json"))
        
        forecast_data = []
        (1..3).each do|week_day|
          day_data = { day: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["date"]["weekday"],
          min: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["low"]["fahrenheit"],
          max: forecast["forecast"]["simpleforecast"]["forecastday"][week_day]["high"]["fahrenheit"] }
          forecast_data << day_data
        end
      
        json_data['forecast'] = forecast_data
  
      end
    end  
      respond_to do |format|
        format.json { render :json => json_data }
      end
  
  end


  def getLiveDataBySite
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

    site_data_json = {site_name: site.dis}
    db = cassandraDbConnection
    
    #if Circuit.where(panel_id: site.id, dis: "Main Power").present?
    
    #Circuit.where(panel_id: site.id, input: 1, active: 1).each do|circuit|
      results = db.execute("select * from emon_live_data where panel='#{site.site_ref}' and channel='totalPower' ALLOW FILTERING")
    
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
  

  private

    def valid_site_check
      #raise params.inspect
      if  params[:site_ref].nil?
        json_data = {"Error" => "Required Parameters: #{'site_ref' if params[:site_ref].nil?}"}
      elsif params[:site_ref].empty?
        json_data = {"Error" => "Value Required for: #{'site_ref' if params[:site_ref].empty?}"}
      else
        if Site.find_by_site_ref(params[:site_ref]).nil?  
          json_data = {"Error" => "Record not found with Site Reference #{params[:site_ref]}"}
        end
      end  
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:area_gross_square_foot, :site_ref, :display, :year_built, :area_cond_square_foot, :operating_hours, :location_id)
    end
end
