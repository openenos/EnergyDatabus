class ElecLoadTypesController < ApplicationController
  before_action :set_elec_load_type, only: [:show, :edit, :update, :destroy]

  # GET /elec_load_types
  # GET /elec_load_types.json
  def index
    @elec_load_types = ElecLoadType.all
  end

  # GET /elec_load_types/1
  # GET /elec_load_types/1.json
  def show
  end

  # GET /elec_load_types/new
  def new
    @elec_load_type = ElecLoadType.new
  end

  # GET /elec_load_types/1/edit
  def edit
  end

  # POST /elec_load_types
  # POST /elec_load_types.json
  def create
    @elec_load_type = ElecLoadType.new(elec_load_type_params)

    respond_to do |format|
      if @elec_load_type.save
        format.html { redirect_to @elec_load_type, notice: 'Elec load type was successfully created.' }
        format.json { render :show, status: :created, location: @elec_load_type }
      else
        format.html { render :new }
        format.json { render json: @elec_load_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elec_load_types/1
  # PATCH/PUT /elec_load_types/1.json
  def update
    respond_to do |format|
      if @elec_load_type.update(elec_load_type_params)
        format.html { redirect_to @elec_load_type, notice: 'Elec load type was successfully updated.' }
        format.json { render :show, status: :ok, location: @elec_load_type }
      else
        format.html { render :edit }
        format.json { render json: @elec_load_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elec_load_types/1
  # DELETE /elec_load_types/1.json
  def destroy
    @elec_load_type.destroy
    respond_to do |format|
      format.html { redirect_to elec_load_types_url, notice: 'Elec load type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elec_load_type
      @elec_load_type = ElecLoadType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def elec_load_type_params
      params.require(:elec_load_type).permit(:load_type, :display)
    end
end
