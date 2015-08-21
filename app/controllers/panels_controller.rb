class PanelsController < ApplicationController
  before_action :set_panel, only: [:show, :edit, :update, :destroy]


  before_filter :panel_account, only: [:index, :new, :create]

  before_filter :admin_check, only: [:update, :edit, :destroy]

  caches_action :index
 
  # GET /panels
  # GET /panels.json
  def index
    @panels = @account.panels
  end

  # GET /panels/1
  # GET /panels/1.json
  def show
    expire_action :action => :index
  end

  # GET /panels/new
  def new
    @panel = @account.panels.new
  end

  # GET /panels/1/edit
  def edit
  end

  # POST /panels
  # POST /panels.json
  def create
    @panel = @account.panels.new(panel_params)

    respond_to do |format|
      if @panel.save
        format.html { redirect_to @panel, notice: 'Panel was successfully created.' }
        format.json { render :show, status: :created, location: @panel }
      else
        format.html { render :new }
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /panels/1
  # PATCH/PUT /panels/1.json
  def update
    respond_to do |format|
      if @panel.update(panel_params)
        format.html { redirect_to @panel, notice: 'Panel was successfully updated.' }
        format.json { render :show, status: :ok, location: @panel }
      else
        format.html { render :edit }
        format.json { render json: @panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /panels/1
  # DELETE /panels/1.json
  def destroy
    @panel.destroy
    respond_to do |format|
      format.html { redirect_to panels_url, notice: 'Panel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_panel
      @panel = Panel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def panel_params
      params.require(:panel).permit(:emon_url, :equip_ref, :panel_type, :parent_panel_id, :site_id, :no_of_circuits, :amp)
    end

    def panel_account
      @account = current_user.account
    end
  
    def admin_check
      unless current_user.is_admin 
        redirect_to :back
      end  
    end
end
