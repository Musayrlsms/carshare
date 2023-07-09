class AdminsController < ApplicationController
  def index
    @cars = Car.all
    @user = User.all
    authorize :admin
  end
  
  def permit
    @car = Car.find(params[:id])
    authorize @car, :permit?
    @car.approved!
    redirect_to admins_path
  end
  def nopermit
      @car = Car.find(params[:id])
      authorize @car, :nopermit?
      @car.rejected!
      redirect_to admins_path
  end


end
