class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  
  def update
    if current_user.update(user_params)
      if current_user.document_upload
        message = "Profil updated: #{user_params.inspect} Document status = #{current_user.document_status}"
        $telegram_bot.api.send_message(chat_id: ENV['TELEGRAM_CHAT_ID'], text: message)
      end
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
    redirect_to document_profilespath
  end
  def rejected
    @user = User.find(params[:profile_id])
    @user.rejected!
    redirect_to document_profiles_path
  end


  def user_params
    params.require(:user).permit(:name, :surname, :mobile_number, :adress, :date_of_birth, :email, :avatar, :identity_card, :passport, :driver_license, :password, :password_confirmation)
  end

end
