class CircuitsController < ApplicationController
  before_action :set_circuit, only: [:show, :edit, :update, :destroy]

  before_filter :circuit_account, only: [:index, :new, :create]
  # GET /circuits
  # GET /circuits.json
  private

  def circuit_account
    @account = current_user.account
  end
  

  public

  def index
    @circuits = @account.circuits
  end

  # GET /circuits/1
  # GET /circuits/1.json
  def show
  end

  # GET /circuits/new
  def new
    @circuit = @account.circuits.new
  end

  # GET /circuits/1/edit
  def edit
  end

  # POST /circuits
  # POST /circuits.json
  def create
    @circuit = @account.circuits.new(circuit_params)

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
