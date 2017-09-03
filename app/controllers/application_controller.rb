class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def login(user)
    session[:user_id] = user.id
  end 

  def logout(user)
    session[:user_id] = nil
  end 

  private
  def current_user
    # return @current_user if @current_user
    # @current_user = User.find_by(id: session[:user_id])
    @current_user ||= User.find_by(id: session[:user_id])
  end 

end
