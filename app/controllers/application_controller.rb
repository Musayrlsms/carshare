class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def change_locale
    locale = params[:locale].to_sym
    locale = I18n.default_locale unless I18n.available_locales.include?(locale)
    cookies.permanent[:locale] = locale
    redirect_back(fallback_location: root_path)
  end

private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_locale
    I18n.locale = cookies[:locale] || I18n.default_locale
  end


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :mobile_number, :adress, :date_of_birth, :avatar, :identity_card, :passport, :driver_license, :email, :password, :current_password)}
    end
end