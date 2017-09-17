class DailyCashflowsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @daily_cash_flow = current_user.daily_cashflows.build
    if params[:date]
      @daily_cash_flow.occur_at = Date.parse(params[:date])
    else 
      @daily_cash_flow.occur_at = Date.today
    end 
  end

  def create 
    @daily_cash_flow = current_user.daily_cashflows.build(daily_cashflow_params)
    if @daily_cash_flow.save 
      flash[:success] = "Create Daily Cashflow successfully"
      redirect_to daily_report_path
    else 
      flash[:error] = "Fail to create a daily Cashflow #{@daily_cash_flow.errors.full_messages.to_sentence}"
      redirect_to new_daily_cashflow_path 
    end 
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
    params.require(:daily_cashflow).permit(:amount, :occur_at, :content, :cashflow_type, :purpose_id, :currency)
  end 

  def daily_report

    if current_user.last_date 
      if params[:date]
        @last_day = Date.parse params[:date]
      else 
        @last_day = Date.today
      end 

      @currency = params[:currency] || "VND"
      @currencies = ["USD", "VND"]
      @cashflows_by_currency = current_user.cashflow_by_day(@last_day, @currency)
      @cashflows_by_day_and_currency = current_user.cashflows_by_day_and_currency(@last_day, @currency)

      @cashflows_hash = {}
      @currencies.each do |currency|
        @cashflows_hash[currency] = current_user.cashflow_by_day(@last_day, currency)
      end 

      @sum_by_day_hash = {}
      @currencies.each do |currency|
        @sum_by_day_hash[currency] = current_user.sum_by_day(@last_day, currency)
      end 

      #sum for purpose pie chart
      @sum_by_day_and_purpose_hash = {}
      @currencies.each do |currency|
        @sum_by_day_and_purpose_hash[currency] = {}
        ["Income", "Expense"].each do |type|
          @sum_by_day_and_purpose_hash[currency][type] = current_user.cashflow_by_day_purpose(@last_day, currency, type)
        end 
      end 

      #use for weekly report
      @sum_by_period_hash = {}
      @currencies.each do |currency|
        @sum_by_period_hash[currency] = {}
        ["Income", "Expense"].each do |type|
          @sum_by_period_hash[currency][type] = current_user.sum_by_between_general(@last_day.beginning_of_week, @last_day, currency, type).group_by_day(:occur_at).sum(:amount)
        end 
      end 

      #use for multi line chart
      @purpose_multiline_chart = Purpose.all.map { |purpose|
          {name: purpose.purpose_name, data: purpose.daily_cashflows.between(@last_day.beginning_of_week, @last_day).group_by_day(:occur_at).sum(:amount)}
      }

      @cashflow_type_multiline_chart = DailyCashflow::CASHFLOW_TYPES.map { |type|
          {name: type, data: current_user.sum_by_between_general(@last_day.beginning_of_week, @last_day, "VND", type).group_by_day(:occur_at).sum(:amount)}
      }

      

      # raise
      # current_user.daily_cashflows.where("occur_at >= ? AND occur_at <= ?", Date.today.beginning_of_week, Date.today).where(currency: "VND").where(cashflow_type: "Income").group_by_day(:occur_at).sum(:amount)
    else 
      flash[:error] = "You don't have any transaction to report! Let's make one"
      redirect_to new_daily_cashflow_path(type: "Income")
    end 
  end 


  def monthly_report
    #Trong monthly report, Quy muon co gi?
    if current_user.last_date 
      if params[:date_before]
        @last_day = Date.parse(params[:date_before]).last_month
      elsif params[:date_after]
        @last_day = Date.parse(params[:date_after]).next_month
      else 
        @last_day = Date.today
      end 
      @last_month_cashflow = current_user.period_cashflows(@last_day.beginning_of_month, @last_day.end_of_month)
      @last_month_cashflow_vnd = @last_month_cashflow.where(currency: "VND")
      # use for pie chart purpose only
      @last_month_vnd_income_purpose = current_user.cashflow_by_period_purpose(@last_day.beginning_of_month, @last_day.end_of_month, "VND", "Income")
      @last_month_vnd_outcome_purpose = current_user.cashflow_by_period_purpose(@last_day.beginning_of_month, @last_day.end_of_month, "VND", "Expense")
      #use for multiline chart
      @purpose_multiline_chart = Purpose.all.map { |purpose|
          {name: purpose.purpose_name, data: purpose.daily_cashflows.between(@last_day.beginning_of_month, @last_day.end_of_month).group_by_day(:occur_at).sum(:amount)}
      }
      @cashflow_type_multiline_chart = DailyCashflow::CASHFLOW_TYPES.map {|type| 
          {name: type, data: current_user.sum_by_between_general(@last_day.beginning_of_month, @last_day.end_of_month, "VND", type).group_by_day(:occur_at).sum(:amount)}
      }
    
  else 
      flash[:error] = "You don't have any transaction to report! Let's make one"
      redirect_to new_daily_cashflow_path
    end 
  end  

  def yearly_report
    if current_user.last_date 
      if params[:date]
        @last_day = Date.parse params[:date]
      else 
        @last_day = Date.today
      end 
      @last_year = @last_day.year
      @last_year_cashflows = current_user.period_cashflows(@last_day.beginning_of_year, @last_day.end_of_year)
      @last_year_cashflows_vnd = @last_year_cashflows.where(currency: "VND")

      @last_year_vnd_income_purpose = current_user.cashflow_by_period_purpose(@last_day.beginning_of_year, @last_day.end_of_year, "VND", "Income")
      @last_year_vnd_outcome_purpose = current_user.cashflow_by_period_purpose(@last_day.beginning_of_year, @last_day.end_of_year, "VND", "Expense")
    else 
      flash[:error] = "You don't have any transaction to report! Let's make one"
      redirect_to new_daily_cashflow_path
    end
  end 

  def all_report
    @all_cashflows = current_user.daily_cashflows
  end 

end
