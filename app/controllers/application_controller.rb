class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :authenticate_user!

  private

  def require_login
    unless current_user
      redirect_to root_path, flash: {error: "Access denied"}
    end 
  end 

  def login(user)
    session[:user_id] = user.id
  end 

  def logout(user)
    session[:user_id] = nil
  end 

  def current_user
    # return @current_user if @current_user
    # @current_user = User.find_by(id: session[:user_id])
    @current_user ||= User.find_by(id: session[:user_id])
  end 

  def authenticate_user!
    unless current_user
      redirect_to login_path
    end 
  end 

end
