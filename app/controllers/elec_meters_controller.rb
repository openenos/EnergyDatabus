class ElecMetersController < ApplicationController
  before_action :set_elec_meter, only: [:show, :edit, :update, :destroy]

  # GET /elec_meters
  # GET /elec_meters.json
  def index
    @elec_meters = ElecMeter.all
  end

  # GET /elec_meters/1
  # GET /elec_meters/1.json
  def show
  end

  # GET /elec_meters/new
  def new
    @elec_meter = ElecMeter.new
  end

  # GET /elec_meters/1/edit
  def edit
  end

  # POST /elec_meters
  # POST /elec_meters.json
  def create
    @elec_meter = ElecMeter.new(elec_meter_params)

    respond_to do |format|
      if @elec_meter.save
        format.html { redirect_to @elec_meter, notice: 'Elec meter was successfully created.' }
        format.json { render :show, status: :created, location: @elec_meter }
      else
        format.html { render :new }
        format.json { render json: @elec_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elec_meters/1
  # PATCH/PUT /elec_meters/1.json
  def update
    respond_to do |format|
      if @elec_meter.update(elec_meter_params)
        format.html { redirect_to @elec_meter, notice: 'Elec meter was successfully updated.' }
        format.json { render :show, status: :ok, location: @elec_meter }
      else
        format.html { render :edit }
        format.json { render json: @elec_meter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elec_meters/1
  # DELETE /elec_meters/1.json
  def destroy
    @elec_meter.destroy
    respond_to do |format|
      format.html { redirect_to elec_meters_url, notice: 'Elec meter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elec_meter
      @elec_meter = ElecMeter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def elec_meter_params
      params.require(:elec_meter).permit(:meter_type, :meter_main, :display, :site_id, :meter_loc, :phase, :amp, :volt)
    end
end
