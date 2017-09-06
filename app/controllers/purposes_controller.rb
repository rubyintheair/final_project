class PurposesController < ApplicationController
  def new
  end

  def create
    @purpose = Purpose.new(purpose_params)
    if @purpose.save 
      flash[:success] = "Created new purpose successfully."
      redirect_to purposes_path
    else 
      flash[:error] = "Fail in create new purpose."
      redirect_to new_purpose_path
    end 
  end

  def index 
    @purposes = Purpose.all 
  end  

  def purpose_params
    params.require(:purpose).permit(:purpose_name)
  end 
end
