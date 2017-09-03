class FriendsController < ApplicationController
  def new
  end

  def create 
    @friend = Friend.new(friends_params)
    if @friend.save 
      flash[:success] = "Quy da tao ra 1 ng ban rou"
      render "index"
    else 
      flash[:error] = "Quy khong the tao ra 1 ng ban dc. Vi sao? Vi #{@friend.error.full_messages.to_sentence}"
      render "new"
    end 
  end 

  def index 
    @friends = Friend.all 
  end 

  def friends_params
    params.require(:friend).permit(:name, :friend_years)
  end 

end
