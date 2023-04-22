class ApplicationController < ActionController::API
  include ActionController::Cookies
  #  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  # helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # private

  # def authenticate_user!
  #   redirect_to login_path, alert: 'You need to login first.' unless current_user
  # end

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  
end
