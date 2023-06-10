class ApplicationController < ActionController::Base

    def change_locale
        locale = params[:locale].to_sym
        locale = I18n.default_locale unless I18n.available_locales.include?(locale)
        cookies.permanent[:locale] = locale
        redirect_back(fallback_location: root_path)
      end
    
      before_action :set_locale
    
      private
    
      def set_locale
        I18n.locale = cookies[:locale] || I18n.default_locale
      end
end