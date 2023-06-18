class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def update
    if current_user.update(user_params)
      redirect_to profiles_path
    else 
      render :update
    end
  end

  def bookings
  end

  def document
    @users = User.all
  end

  def approved
    @user = User.find(params[:profile_id])
    @user.approved!
    redirect_to document_path
  end
  def rejected
    @user = User.find(params[:profile_id])
    @user.rejected!
    redirect_to document_path
  end


  def user_params
    params.require(:user).permit(:name, :surname, :mobile_number, :adress, :date_of_birth, :email, :avatar, :identity_card, :passport, :driver_license, :password, :password_confirmation)
  end

end
