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

  def index
    @daily_cash_flows = current_user.daily_cashflows.all
    @incomes = current_user.type_cashflow(@daily_cash_flows, 2).sum {|e| e.amount}
    @outcomes = current_user.type_cashflow(@daily_cash_flows, 3).sum {|e| e.amount}
    @total = @incomes - @outcomes
    
    @purpose_1 = current_user.purpose_cashflow( @daily_cash_flows, 1).sum {|e| e.amount}
    @purpose_2 = current_user.purpose_cashflow( @daily_cash_flows, 2).sum {|e| e.amount}
    @purpose_3 = current_user.purpose_cashflow( @daily_cash_flows, 3).sum {|e| e.amount}
    @purpose_4 = current_user.purpose_cashflow( @daily_cash_flows, 4).sum {|e| e.amount}
    @purpose_5 = current_user.purpose_cashflow( @daily_cash_flows, 5).sum {|e| e.amount}
    @purpose_6 = current_user.purpose_cashflow( @daily_cash_flows, 6).sum {|e| e.amount}
    @purpose_7 = current_user.purpose_cashflow( @daily_cash_flows, 7).sum {|e| e.amount}
    @purpose_8 = current_user.purpose_cashflow( @daily_cash_flows, 8).sum {|e| e.amount}
    @purpose_9 = current_user.purpose_cashflow( @daily_cash_flows, 9).sum {|e| e.amount}
    @purpose_10 = current_user.purpose_cashflow( @daily_cash_flows, 10).sum {|e| e.amount}

    @all_purposes = [@purpose_1, @purpose_2, @purpose_3, @purpose_4, @purpose_5, @purpose_6, @purpose_7, @purpose_8, @purpose_9, @purpose_10 ]
    
    @the_last_day = @daily_cash_flows.map {|e| e.occur_at }.max
    @the_last_day_cashflows = @daily_cash_flows.select {|e| e.occur_at == @the_last_day }
    @the_last_day_cashflows_total = @daily_cash_flows.select {|e| e.occur_at == @the_last_day }.sum {|e| e.amount}
    if params[:action] == "search"
      @count = @period_cashflows.count
    end 
  end 

  def daily_cashflow_params
    params.require(:daily_cashflow).permit(:amount, :occur_at, :content)
  end 

  def search
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @purpose = Purpose.find(params[:purposes_id].to_i).purpose_name
    if (@start_date && @end_date && @purpose)
      @period_cashflows = DailyCashflow.where("date(occur_at) in (?)", params[:start_date]).first.amount
      flash[:success] = "We have searched based on START_DATE, END_DATE and PURPOSE"
    elsif (@start_date && @end_date)
      @period_cashflows = DailyCashflow.where("date(occur_at) in (?)", params[:start_date]).first.amount
      flash[:success] = "We have searched based on START_DATE and END_DATE"
    elsif (@purpose)
      flash[:success] = "We have searched based on PURPOSE"
    else 
      flash[:error] = "Nothing in the params"
    end 
  end 
end
