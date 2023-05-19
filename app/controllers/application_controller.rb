class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_email_confirmation, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio])
  end

  def check_email_confirmation
    return unless user_signed_in? && !current_user.confirmed?

    flash.now[:alert] = 'Please verify your email address before accessing your account.'
  end
end
