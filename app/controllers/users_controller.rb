class UsersController < ApplicationController
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
      render "index"
    else 
      flash[:error] = "Can not create user"
      render "new"
    end 
  end 

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end
