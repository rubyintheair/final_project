class DailyCashflowsController < ApplicationController
  def new
    @daily_cash_flow = current_user.daily_cashflows.build
  end

  def create 
    @daily_cash_flow = current_user.daily_cashflows.build(daily_cashflow_params)
    @daily_cash_flow.cashflow_type = CashflowType.find(params[:cashflow_types_id].to_i)
    @daily_cash_flow.purpose = Purpose.find(params[:purposes_id].to_i)
    if @daily_cash_flow.save 
      flash[:success] = "Create Daily Cashflow without friend successfully"
      redirect_to daily_cashflows_path
    else 
      flash[:error] = "Fail to create a daily Cashflow #{@daily_cash_flow.errors.full_messages.to_sentence}"
      redirect_to new_daily_cashflow_path
    end 
  end 

  def daily_cashflow_params
    params.require(:daily_cashflow).permit(:amount, :occur_at, :content)
  end 

  def index
    @daily_cash_flows = DailyCashflow.all
    @incomes = @daily_cash_flows.select {|e| e.cashflow_type_id == 1}.sum {|e| e.amount}
    @outcomes = @daily_cash_flows.select {|e| e.cashflow_type_id == 2}.sum {|e| e.amount}
    @total = @incomes - @outcomes
    @purpose_1 = @daily_cash_flows.select {|e| e.purpose_id == 1}.sum {|e| e.amount}
    @purpose_2 = @daily_cash_flows.select {|e| e.purpose_id == 2}.sum {|e| e.amount}
    @purpose_3 = @daily_cash_flows.select {|e| e.purpose_id == 3}.sum {|e| e.amount}
    @purpose_4 = @daily_cash_flows.select {|e| e.purpose_id == 4}.sum {|e| e.amount}
    @purpose_5 = @daily_cash_flows.select {|e| e.purpose_id == 5}.sum {|e| e.amount}
    @purpose_6 = @daily_cash_flows.select {|e| e.purpose_id == 6}.sum {|e| e.amount}
    @purpose_7 = @daily_cash_flows.select {|e| e.purpose_id == 7}.sum {|e| e.amount}
    @purpose_8 = @daily_cash_flows.select {|e| e.purpose_id == 8}.sum {|e| e.amount}
    @purpose_9 = @daily_cash_flows.select {|e| e.purpose_id == 9}.sum {|e| e.amount}
    @purpose_10 = @daily_cash_flows.select {|e| e.purpose_id == 10}.sum {|e| e.amount}
    @the_last_day = @daily_cash_flows.map {|e| e.occur_at }.max
    @the_last_day_cashflows = @daily_cash_flows.select {|e| e.occur_at == @the_last_day }
    @the_last_day_cashflows_total = @daily_cash_flows.select {|e| e.occur_at == @the_last_day }.sum {|e| e.amount}
  end 
end
