class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :configure_devise_parameters, if: :devise_controller?

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:nickname, :first_name, :last_name, :age, :email, :phone_number, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:nickname, :first_name, :last_name, :age, :email, :phone_number, :current_password, :password, :password_confirmation)}
  end

end
