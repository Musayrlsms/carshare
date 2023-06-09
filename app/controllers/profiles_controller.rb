class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
  
  end

  def update
    if current_user.update(user_params)
      redirect_to profiles_index_path
    else 
      render :update
    end
  end

  
  def edit
    current_user
  end

  def update_password
    if current_user.update(user_params)
      bypass_sign_in(current_user)
      redirect_to profiles_index_path
    else
      render "edit"
    end
  end

  def user_params
    params.require(:user).permit(:name, :surname, :mobile_number, :adress, :date_of_birth, :email, :avatar, :identity_card, :passport, :driver_license, :password, :password_confirmation)
  end

end
