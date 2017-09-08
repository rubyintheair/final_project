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
    #tat ca incomes cua current_user
    @incomes = @daily_cash_flows.select {|e| e.cashflow_type_id == 2}.sum {|e| e.amount}
    #tat ca outcomes cua current_user
    @outcomes = @daily_cash_flows.select {|e| e.cashflow_type_id == 3}.sum {|e| e.amount}
    #totals
    @total = @incomes - @outcomes
    
    #gia tri sum theo purpose cua tat ca transactions
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
    @purpose_11 = current_user.purpose_cashflow( @daily_cash_flows, 11).sum {|e| e.amount}
    @purpose_12 = current_user.purpose_cashflow( @daily_cash_flows, 12).sum {|e| e.amount}
    @purpose_13 = current_user.purpose_cashflow( @daily_cash_flows, 13).sum {|e| e.amount}

    @all_purposes = [@purpose_1, @purpose_2, @purpose_3, @purpose_4, @purpose_5, @purpose_6, @purpose_7, @purpose_8, @purpose_9, @purpose_10, @purpose_11, @purpose_12, @purpose_13 ]
    
    #tim ngay gan nhat cua tat ca transactions
    @the_last_day = @daily_cash_flows.map {|e| e.occur_at.to_date }.max

    @the_last_day_cashflows = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }
    @the_last_day_cashflows_incomes = @daily_cash_flows.select {|e| e.occur_at == @the_last_day }.select do |e|
                                        e.cashflow_type_id == 2
                                      end.sum {|e| e.amount}
    @the_last_day_cashflows_outcomes = @daily_cash_flows.select {|e| e.occur_at == @the_last_day }.select do |e|
                                        e.cashflow_type_id == 3
                                      end.sum {|e| e.amount}                                      
    @the_last_day_cashflows_total = @the_last_day_cashflows_incomes - @the_last_day_cashflows_outcomes
  end 

  def daily_cashflow_params
    params.require(:daily_cashflow).permit(:amount, :occur_at, :content)
  end 

  def search
    @cashflows = current_user.daily_cashflows.all
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @purpose = Purpose.find(params[:purposes_id]).purpose_name
    if (params[:purposes_id] == "14")
      if (params[:start_date] && params[:end_date])
        @period_cashflows = @cashflows.select {|e| e.occur_at.to_date == params[:start_date].to_date}
        @period_cashflows = @cashflows.select do |e| 
                              (e.occur_at.to_date >= params[:start_date].to_date && e.occur_at.to_date <= params[:end_date].to_date)
                            end 
        flash[:success] = "We have searched based on START_DATE and END_DATE"
      else 
        flash[:error] = "Nothing in the params"
      end
    else 
      if (params[:start_date] && params[:end_date])
        @period_cashflows = @cashflows.select {|e| e.occur_at.to_date == params[:start_date].to_date}.select{|e| e.purpose_id == params[:purposes_id].to_i}
        flash[:success] = "We have searched based on START_DATE, END_DATE and PURPOSE"
      elsif (params[:purposes_id].to_i) 
        flash[:success] = "We have searched based on PURPOSE"
        @period_cashflows = @cashflows.select {|e| e.purpose_id == params[:purposes_id].to_i } 
      end 
    end 
    
    @incomes = @period_cashflows.select { |e| e.cashflow_type_id == 2 }.sum {|e| e.amount }
    @outcomes = @period_cashflows.select { |e| e.cashflow_type_id == 3}.sum {|e| e.amount}
    @total = @incomes - @outcomes
  end 
end
