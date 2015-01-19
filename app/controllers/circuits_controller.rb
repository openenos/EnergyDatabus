class CircuitsController < ApplicationController
  before_action :set_circuit, only: [:show, :edit, :update, :destroy]

  # GET /circuits
  # GET /circuits.json
  def index
    @circuits = Circuit.all
  end

  # GET /circuits/1
  # GET /circuits/1.json
  def show
  end

  # GET /circuits/new
  def new
    @circuit = Circuit.new
  end

  # GET /circuits/1/edit
  def edit
  end

  # POST /circuits
  # POST /circuits.json
  def create
    @circuit = Circuit.new(circuit_params)

    respond_to do |format|
      if @circuit.save
        format.html { redirect_to @circuit, notice: 'Circuit was successfully created.' }
        format.json { render :show, status: :created, location: @circuit }
      else
        format.html { render :new }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /circuits/1
  # PATCH/PUT /circuits/1.json
  def update
    respond_to do |format|
      if @circuit.update(circuit_params)
        format.html { redirect_to @circuit, notice: 'Circuit was successfully updated.' }
        format.json { render :show, status: :ok, location: @circuit }
      else
        format.html { render :edit }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /circuits/1
  # DELETE /circuits/1.json
  def destroy
    @circuit.destroy
    respond_to do |format|
      format.html { redirect_to circuits_url, notice: 'Circuit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get7DaysRuntimInfo
    site_ref = params[:site_ref]
    site = Site.find_by_site_ref(site_ref)
    givenChannel = params[:channel]
    
    site_data_json = {site_name: site.dis}    
    
    beginningDay = (Time.now - 8.day).beginning_of_day.to_i
    endingDay = (Time.now - 1.day).end_of_day.to_i
    db = cassandraDbConnection
    Circuit.where(panel_id: site.id, channel_no: "#{givenChannel}", input: 0, active: 1).each do|circuit|
      results = db.execute("select * from emon_hourly_runtime where panel='#{site.site_ref}' and channel='CH-#{circuit.channel_no}' and asof_hr>=#{beginningDay} and asof_hr<#{endingDay} ALLOW FILTERING")
      
      totalMinutes = 0
      results.each do|result|
        totalMinutes = result['value'] + totalMinutes
      end
       site_data_json['duration'] = "#{Time.at(totalMinutes).utc.strftime("%H:%M:%S")}"
    end
    respond_to do |format|
        format.json { render :json => site_data_json }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit
      @circuit = Circuit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circuit_params
      params.require(:circuit).permit(:active, :input, :breaker_number, :double_breaker, :breaker_size, :display, :elec_load_type_id, :panel_id, :ct_sensor_type, :double_ct, :channel_no)
    end
end
