class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  
  def update
    if current_user.update(user_params)
      if current_user.document_upload

        user_info = "Profil updated:\n" +
        "Name: #{current_user.name}\n" +
        "Surname: #{current_user.surname}\n" +
        "Adress: #{current_user.adress}\n" +
        "Document status = #{current_user.document_status}\n" +
        "İdentity_card = #{current_user.identity_card}\n" +
        "Passport = #{current_user.passport}\n" +
        "Document status = #{current_user.driver_license}\n" 
        message = user_info
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
