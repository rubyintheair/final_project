class CategoriesController < ApplicationController
  def new 
  end 
  
  def create
    @category = Category.new(category_params)
    if @category.save 
      flash[:success] = "Quy da tao category thanh cong"
      redirect_to users_path
    else
      flash[:error] = "Tao category fail rou, Quy rang tao lai nha #{@category.errors.full_messages.to_sentence}"
      render "new"
    end 
  end 

  def category_params
    params.require(:category).permit(:type)
  end 

  def index
  end 
end
