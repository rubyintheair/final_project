class PurposesController < ApplicationController
  def new
  end

  def create
    @purpose = Purpose.new(purpose_params)
    if @purpose.save 
      flash[:success] = "Created new purpose successfully."
      render "index"
    else 
      flash[:error] = "Fail in create new purpose."
      render "new"
    end 
  end

  def index 
    @purposes = Purpose.all 
  end  

  def purpose_params
    params.require(:purpose).permit(:purpose_name)
  end 
end
