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
    CarMailer.approved_email(@car).deliver_now
    redirect_to admins_path, notice: 'Araba bilgileri onaylandı ve e-posta gönderildi.'


  end
  
  def nopermit
      @car = Car.find(params[:id])
      authorize @car, :nopermit?
      @car.rejected!
      redirect_to admins_path
  end


end
