class ProfilesController < ApplicationController
  before_action :authenticate_user!
  
  def index; end
  
  def update
    @user = current_user
    authorize @user, :update?
    if current_user.update(user_params)
      if current_user.document_upload?
        user_info = "Profil updated:\n" +
        "Name: #{current_user.name}\n" +
        "Surname: #{current_user.surname}\n" +
        "Adress: #{current_user.adress}\n" +
        "Document Status = #{current_user.document_status}\n" +
        "İdentity Card = #{url_for(current_user.identity_card)}\n" +
        "Passport = #{url_for(current_user.passport)}\n" +
        "Driver License = #{url_for(current_user.driver_license)}\n" +
        "Approved = #{url_for(controller: 'profiles', action: 'approved', id: current_user.id, host: request.host_with_port)}\n"+
        "Rejected = #{url_for(controller: 'profiles', action: 'rejected', id: current_user.id, host: request.host_with_port)}"
        message = user_info
        $telegram_bot.api.send_message(chat_id: ENV['TELEGRAM_CHAT_ID'], text: message)
      end
      flash[:success] = 'Thank you for openning account with Oi-jo. We are reviewing your documents and we will send you activation link on your email.'
      redirect_to profiles_path
    else
      flash[:error] = current_user.errors.full_messages.join(", ")
      render :index
    end
  end

  def bookings
    @bookings = Rent.where(renter: current_user)
    @upcoming_bookings = @bookings.paid.where.not('finish_date < ?', DateTime.now)
    @canceled_bookings = @bookings.canceled 
    @completed_bookings = @bookings.paid.where('finish_date < ?', DateTime.now)
  end

  def bank_accounts
    
  end

  def document
    @users = User.all
    authorize current_user
  end

  def approved
    @user = User.find(params[:id])
    authorize @user, :approved?
    @user.approved!
    redirect_to document_profiles_path
  end

  def balance
    @balance = Stripe::Balance.retrieve({stripe_account: current_user.stripe_account.account_id})
  end

  def rejected
    @user = User.find(params[:id])
    authorize @user, :rejected?
    @user.rejected!
    redirect_to document_profiles_path
  end

  def cars
    @cars = current_user.cars
  end

  def user_params
    params.require(:user).permit(:name, :surname, :mobile_number, :adress, :date_of_birth,:email, :avatar,
                                 :identity_card, :passport, :driver_license, :password, :password_confirmation)
  end
end
