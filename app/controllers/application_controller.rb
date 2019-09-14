class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def correct_owner
    end


    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_kana, :first_kana, :phone_number])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:last_name, :first_name, :last_kana, :first_kana, :phone_number])
    end


end
