class DailyCashflowsController < ApplicationController
  def new
    @daily_cash_flow = current_user.daily_cashflows.build
  end

  def create 
    @daily_cash_flow = current_user.daily_cashflows.build(daily_cashflow_params)
    @daily_cash_flow.cashflow_type = CashflowType.find(params[:cashflow_types_id].to_i)
    @daily_cash_flow.purpose = Purpose.find(params[:purposes_id].to_i)
    @daily_cash_flow.friend = Friend.find(params[:friends_id].to_i)
    if @daily_cash_flow.save 
      if Friend.find(params[:friends_id].to_i)
        flash[:success] = "Create Daily Cashflow with friend successfully"
        @daily_cash_flow.friend = Friend.find(params[:friends_id].to_i)
        @daily_cash_flow.save 
      else 
        flash[:success] = "Create Daily Cashflow without friend successfully"
      end 
      render "index"
    else 
      flash[:error] = "Fail to create a daily Cashflow #{@daily_cash_flow.errors.full_messages.to_sentence}"
      render "new"
    end 
  end 

  def daily_cashflow_params
    params.require(:daily_cashflow).permit(:amount, :occur_at, :content)
  end 

  def index

    @daily_cash_flows = DailyCashflow.all
    @incomes = DailyCashflow.all.select {|e| e.cashflow_type_id == 2}.sum {|e| e.amount}
    @outcomes = DailyCashflow.all.select {|e| e.cashflow_type_id == 3}.sum {|e| e.amount}
    @total = @incomes - @outcomes
    @purpose_3 = DailyCashflow.all.select {|e| e.purpose_id == 3}.sum {|e| e.amount}
    @purpose_4 = DailyCashflow.all.select {|e| e.purpose_id == 4}.sum {|e| e.amount}
  end 
end
