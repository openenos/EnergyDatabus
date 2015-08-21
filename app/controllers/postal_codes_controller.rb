class PostalCodesController < ApplicationController
  before_action :set_postal_code, only: [:show, :edit, :update, :destroy]

  before_filter :postal_code_account, only: [:index, :new, :create]

  before_filter :admin_check, only: [:update, :edit, :destroy]
  # GET /postal_codes
  # GET /postal_codes.json
  def index
    @postal_codes = @account.postal_codes
  end

  # GET /postal_codes/1
  # GET /postal_codes/1.json
  def show
  end

  # GET /postal_codes/new
  def new
    @postal_code = @account.postal_codes.new
  end

  # GET /postal_codes/1/edit
  def edit
  end

  # POST /postal_codes
  # POST /postal_codes.json
  def create
    @postal_code = @account.postal_codes.new(postal_code_params)

    respond_to do |format|
      if @postal_code.save
        format.html { redirect_to @postal_code, notice: 'Postal code was successfully created.' }
        format.json { render :show, status: :created, location: @postal_code }
      else
        format.html { render :new }
        format.json { render json: @postal_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postal_codes/1
  # PATCH/PUT /postal_codes/1.json
  def update
    respond_to do |format|
      if @postal_code.update(postal_code_params)
        format.html { redirect_to @postal_code, notice: 'Postal code was successfully updated.' }
        format.json { render :show, status: :ok, location: @postal_code }
      else
        format.html { render :edit }
        format.json { render json: @postal_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postal_codes/1
  # DELETE /postal_codes/1.json
  def destroy
    @postal_code.destroy
    respond_to do |format|
      format.html { redirect_to postal_codes_url, notice: 'Postal code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postal_code
      @postal_code = PostalCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postal_code_params
      params.require(:postal_code).permit(:geo_postal_code, :geo_city, :geo_state, :geo_country, :tz, :weather_ref)
    end

    def postal_code_account
      @account = current_user.account
    end
  
    def admin_check
      unless current_user.is_admin 
        redirect_to :back
      end  
    end
end
