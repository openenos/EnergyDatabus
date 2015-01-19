class SiteGroupMappingsController < ApplicationController
  before_action :set_site_group_mapping, only: [:show, :edit, :update, :destroy]

  # GET /site_group_mappings
  # GET /site_group_mappings.json
  def index
    @site_group_mappings = SiteGroupMapping.all
  end

  # GET /site_group_mappings/1
  # GET /site_group_mappings/1.json
  def show
  end

  # GET /site_group_mappings/new
  def new
    @site_group_mapping = SiteGroupMapping.new
  end

  # GET /site_group_mappings/1/edit
  def edit
  end

  # POST /site_group_mappings
  # POST /site_group_mappings.json
  def create
    @site_group_mapping = SiteGroupMapping.new(site_group_mapping_params)

    respond_to do |format|
      if @site_group_mapping.save
        format.html { redirect_to @site_group_mapping, notice: 'Site group mapping was successfully created.' }
        format.json { render :show, status: :created, location: @site_group_mapping }
      else
        format.html { render :new }
        format.json { render json: @site_group_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_group_mappings/1
  # PATCH/PUT /site_group_mappings/1.json
  def update
    respond_to do |format|
      if @site_group_mapping.update(site_group_mapping_params)
        format.html { redirect_to @site_group_mapping, notice: 'Site group mapping was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_group_mapping }
      else
        format.html { render :edit }
        format.json { render json: @site_group_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_group_mappings/1
  # DELETE /site_group_mappings/1.json
  def destroy
    @site_group_mapping.destroy
    respond_to do |format|
      format.html { redirect_to site_group_mappings_url, notice: 'Site group mapping was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def usageByGroup    
    if params[:group_id].nil? || params[:from].nil? || params[:to].nil?
      json_data = {"Error" => "Required Parameters: #{'group_id' if params[:group_id].nil?} #{'date_from' if params[:from].nil?} #{'date_to' if params[:to].nil?}"}
    elsif params[:group_id].empty? || params[:from].empty? || params[:to].empty?
      json_data = {"Error" => "Required Parameters: #{'group_id' if params[:group_id].empty?} #{'date_from' if params[:from].empty?} #{'date_to' if params[:to].empty?}"}
    else
    begin
      group_id = params[:group_id]
      date_from =  params[:from] # format "02-06-2014"
      date_to =  params[:to] # format "03-06-2014"
      db = cassandraDbConnection
      
      group_time_zone = SiteGroup.find(params[:group_id]).sites.first.location.postal_code.tz
      
      beginningDay = (date_to.to_datetime.beginning_of_day.to_time).utc.to_i
      endingDay = (date_from.to_datetime.end_of_day.to_time).utc.to_i
      
      json_data = []
      SiteGroupMapping.where(site_group_id: group_id).each do|siteGroupMapping|
        site_data_json = {}
        site_data_json[:site_name] = siteGroupMapping.site.dis
        site_data_json[:site_ref] = siteGroupMapping.site.site_ref
        site_data_json[:lat] = siteGroupMapping.site.location.geo_lat.to_f
        site_data_json[:lng] = siteGroupMapping.site.location.geo_lng.to_f
        site_data = { kwh: 0, kwhpersqft: 0, cost: 0, costsqft: 0}
        site_data_json[:data] = site_data
        
        #if Circuit.where(panel_id: siteGroupMapping.site.id, dis: "Main Power").present?
        
        #Circuit.where(panel_id: siteGroupMapping.site.id, input: 1, active: 1).each do|circuit|
            results = db.execute("select * from emon_daily_data where panel='#{siteGroupMapping.site.site_ref}' and channel='totalPower' and asof_day>=#{endingDay} and asof_day<#{beginningDay} ALLOW FILTERING")
            sum_of_main_power = 0.0;
            results.each do|result|
              sum_of_main_power =  result['value'].to_f + sum_of_main_power
            end
            kwhpersqft=0
            costsqft = 0
            kwhpersqft = (sum_of_main_power)/siteGroupMapping.site.area_gross_square_foot.to_f  if siteGroupMapping.site.area_gross_square_foot.to_f!=0
            cost = sum_of_main_power * siteGroupMapping.site.location.utility.base_rate.to_f
      costsqft = cost/siteGroupMapping.site.area_gross_square_foot.to_f  if siteGroupMapping.site.area_gross_square_foot.to_f!=0 if kwhpersqft.present? && cost!=0

            site_data = { kwh: sum_of_main_power, kwhpersqft: kwhpersqft, cost: cost, costsqft: costsqft}

            site_data_json[:data] = site_data
        #end      
        json_data<< site_data_json unless site_data_json.empty?
        #end
      end
      
      rescue  Exception => e 
        json_data = {"Error" => e.message }
      end
      
    end
    respond_to do |format|
        format.json { render :json => json_data }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_group_mapping
      @site_group_mapping = SiteGroupMapping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_group_mapping_params
      params.require(:site_group_mapping).permit(:site_group_id, :site_id)
    end
end
