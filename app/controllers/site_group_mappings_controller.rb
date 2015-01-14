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
