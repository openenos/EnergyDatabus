class SiteGroupsController < ApplicationController
  before_action :set_site_group, only: [:show, :edit, :update, :destroy]

  # GET /site_groups
  # GET /site_groups.json
  def index
    @site_groups = SiteGroup.all
  end

  # GET /site_groups/1
  # GET /site_groups/1.json
  def show
  end

  # GET /site_groups/new
  def new
    @site_group = SiteGroup.new
  end

  # GET /site_groups/1/edit
  def edit
  end

  # POST /site_groups
  # POST /site_groups.json
  def create
    @site_group = SiteGroup.new(site_group_params)

    respond_to do |format|
      if @site_group.save
        format.html { redirect_to @site_group, notice: 'Site group was successfully created.' }
        format.json { render :show, status: :created, location: @site_group }
      else
        format.html { render :new }
        format.json { render json: @site_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /site_groups/1
  # PATCH/PUT /site_groups/1.json
  def update
    respond_to do |format|
      if @site_group.update(site_group_params)
        format.html { redirect_to @site_group, notice: 'Site group was successfully updated.' }
        format.json { render :show, status: :ok, location: @site_group }
      else
        format.html { render :edit }
        format.json { render json: @site_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_groups/1
  # DELETE /site_groups/1.json
  def destroy
    @site_group.destroy
    respond_to do |format|
      format.html { redirect_to site_groups_url, notice: 'Site group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_group
      @site_group = SiteGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_group_params
      params.require(:site_group).permit(:display)
    end
end
