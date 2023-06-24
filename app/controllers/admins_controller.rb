class AdminsController < ApplicationController
  def index
    @cars = Car.all
    @user = User.all
  end
  
  def permit
    @car = Car.find(params[:id])
    @car.approved!
    redirect_to admins_path
  end
  def nopermit
      @car = Car.find(params[:id])
      @car.rejected!
      redirect_to admins_path
  end


end
