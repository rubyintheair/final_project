class CashflowTypesController < ApplicationController
  def new
  end

  def create 
    @cashflowtype = CashflowType.new(cashflowtype_params)
    if @cashflowtype.save 
      flash[:success] = "Quy created a cashflowtype successfully"
      render "index"
    else 
      flash[:error] = "It's failed to create a cashflowtype"
      render "new"
    end 
  end 

  def index 
    @cashflowtypes = CashflowType.all 
  end 

  def cashflowtype_params
    params.require(:cashflow_type).permit(:trend)
  end 
end
