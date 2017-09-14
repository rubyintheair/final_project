class UsersController < ApplicationController
  before_action :require_login, only: [:index]

  def index 
    @users = User.all
  end 

  def new
  end

  def create 
    @user = User.new(users_params) 
    if @user.save 
      login(@user)
      flash[:success] = "User created"
      redirect_to new_daily_cashflow_path
    else 
      flash[:error] = "Can not create user"
      redirect_to new_user_path
    end 
  end 

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end
