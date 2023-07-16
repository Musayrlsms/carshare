class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]   

  # GET /cars or /cars.json
  def index
    @q = Car.ransack(params[:q])
    @cars = @q.result.includes(:model).paginate(:page => params[:page])
    
    @brands = Brand.all
    @models = Model.all
    @car = Car.new
    authorize @car
  end

  # GET /cars/1 or /cars/1.json
  def show
    @car = Car.find(params[:id])
    authorize @car
  end


  # GET /cars/new
  def new
    redirect_to(profiles_path, notice: "You can't rent a car before your account approved.") and return unless current_user.approved?
    @car = Car.new
    authorize @car
  end

  # GET /cars/1/edit
  def edit
    @car = Car.find(params[:id])
    authorize @car
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "You are not authorized to edit this car."
    redirect_to cars_path
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    @car = Car.find(params[:id])
    authorize @car
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car = Car.find(params[:id])
    authorize @car
    @car.destroy

    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

private
def self.ransackable_attributes(auth_object = nil)
  ["address", "brand_id", "case_type", "city", "created_at", "details", "distance", "email", "id", "max_luggage", "model_id", "model_year", "phone_number", "price", "seat_count", "state", "status", "updated_at", "user_id", "user_name", "user_surname"]
end
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:details, :longitude, :latitude, :model_id, :brand_id, :user_id, :distance, :max_luggage, :seat_count, :case_type, :price, :email, :phone_number, :user_name, :user_surname, :address, :state, :city, :model_year, images: [], insurance_images: [], registration_images: [], rule_ids: [])
    end
end
