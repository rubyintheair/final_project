class DailyCashflowsController < ApplicationController
  def new
    @daily_cash_flow = current_user.daily_cashflows.build(occur_at: Time.now)
  end

  def create 
    @daily_cash_flow = current_user.daily_cashflows.build(daily_cashflow_params)
    if @daily_cash_flow.save 
      flash[:success] = "Create Daily Cashflow without friend successfully"
      redirect_to daily_cashflows_path
    else 
      flash[:error] = "Fail to create a daily Cashflow #{@daily_cash_flow.errors.full_messages.to_sentence}"
      redirect_to new_daily_cashflow_path 
    end 
  end 

  def index
    @daily_cash_flows = current_user.daily_cashflows
    @incomes = @daily_cash_flows.select {|e| e.cashflow_type.trend == "Income"}.sum {|e| e.amount}
    @outcomes = @daily_cash_flows.select {|e| e.cashflow_type.trend == "Outcome"}.sum {|e| e.amount}
    @total = @incomes - @outcomes
    
    

    @currency_vnd = @daily_cash_flows.select {|e| e.currency.name == "VND"}
    @currency_eur = @daily_cash_flows.select {|e| e.currency.name == "EUR"}
    @currency_usd = @daily_cash_flows.select {|e| e.currency.name == "USD"}

    @currency_all = Currency.all.map.with_index do |currency, index|
      @daily_cash_flows.select {|e| e.currency_id.to_i == index + 1}
    end 


    
    

    #Quy can tim 

    @income_all_purposes = Purpose.all.map.with_index do |purpose, index|
      current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
          type.cashflow_type.trend == "Income"
        end.sum{|e| e.amount}
      end 
    @test_graph_outcome = Purpose.all.map.with_index do |purpose, index|
      [purpose.purpose_name, current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
          type.cashflow_type.trend == "Outcome"
        end.sum{|e| e.amount}]
      end 
    
    @test_graph_income = Purpose.all.map.with_index do |purpose, index|
      [purpose.purpose_name, current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
          type.cashflow_type.trend == "Income"
        end.sum{|e| e.amount}]
      end 
    @outcome_all_purposes = Purpose.all.map.with_index do |purpose, index|
      current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
          type.cashflow_type.trend == "Outcome"
        end.sum{|e| e.amount}
      end 
    @all_purposes = Purpose.all.map.with_index do |purpose, index|
      current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.sum{|e| e.amount}
      end 
    #tim ngay gan nhat cua tat ca transactions
    @the_last_day = @daily_cash_flows.map {|e| e.occur_at.to_date }.max

    @the_last_day_cashflows = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }
    @the_last_day_cashflows_incomes = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }.select do |e|
                                        e.cashflow_type.trend == "Income"
                                      end.sum {|e| e.amount}
    @the_last_day_cashflows_outcomes = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }.select do |e|
                                        e.cashflow_type.trend == "Outcome"
                                      end.sum {|e| e.amount}                                      
    @the_last_day_cashflows_total = @the_last_day_cashflows_incomes - @the_last_day_cashflows_outcomes
  end 

  

  def search
    @cashflows = current_user.daily_cashflows.all
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    if (params[:purposes_id] == "")
      if (params[:start_date] && params[:end_date])
        @period_cashflows = @cashflows.select do |e| 
                              (e.occur_at.to_date >= params[:start_date].to_date && e.occur_at.to_date <= params[:end_date].to_date)
                            end 
        flash[:success] = "We have searched based on START_DATE and END_DATE"
      else 
        flash[:error] = "Nothing in the params"
      end
    else 
      if (params[:start_date] && params[:end_date])
        @period_cashflows = @cashflows.select do |e| 
                              (e.occur_at.to_date >= params[:start_date].to_date && e.occur_at.to_date <= params[:end_date].to_date)
                            end.select{|e| e.purpose_id == params[:purposes_id].to_i} 
        flash[:success] = "We have searched based on START_DATE, END_DATE and PURPOSE"
      elsif (params[:purposes_id].to_i) 
        flash[:success] = "We have searched based on PURPOSE"
        @period_cashflows = @cashflows.select {|e| e.purpose_id == params[:purposes_id].to_i } 
      end 
    end     
    @incomes = @period_cashflows.select { |e| e.cashflow_type.trend == "Income" }.sum {|e| e.amount }
    @outcomes = @period_cashflows.select { |e| e.cashflow_type.trend == "Outcome" }.sum {|e| e.amount}
    @total = @incomes - @outcomes

    @all_purposes = Purpose.all.map.with_index do |purpose, index|
      @period_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.sum{|e| e.amount}
      end 
  end 

  def daily_cashflow_params
    params.require(:daily_cashflow).permit(:amount, :occur_at, :content, :cashflow_type_id, :purpose_id, :currency_id)
  end 

end
