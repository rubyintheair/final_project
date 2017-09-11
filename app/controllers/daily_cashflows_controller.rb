class DailyCashflowsController < ApplicationController
  def new
    @daily_cash_flow = current_user.daily_cashflows.build(occur_at: Time.now)
  end

  def create 
    @daily_cash_flow = current_user.daily_cashflows.build(daily_cashflow_params)
    if @daily_cash_flow.save 
      flash[:success] = "Create Daily Cashflow without friend successfully"
      redirect_to daily_report_path
    else 
      flash[:error] = "Fail to create a daily Cashflow #{@daily_cash_flow.errors.full_messages.to_sentence}"
      redirect_to new_daily_cashflow_path 
    end 
  end 

  # def index
  #   @daily_cash_flows = current_user.daily_cashflows
  #   @currency_all = Currency.all.map.with_index do |currency, index|
  #     @daily_cash_flows.select {|e| e.currency_id.to_i == index + 1}
  #   end 

  #   @currency_income_all = Currency.all.map.with_index do |currency, index|
  #     @daily_cash_flows.select {|e| e.currency_id.to_i == index + 1 && e.cashflow_type.trend == "Income"}
  #   end 

  #   @currency_outcome_all = Currency.all.map.with_index do |currency, index|
  #     @daily_cash_flows.select {|e| e.currency_id.to_i == index + 1 && e.cashflow_type.trend == "Outcome"}
  #   end 

  #   @currency_vnd = @daily_cash_flows.select {|e| e.currency.name == "VND"}
  #   @currency_vnd_line_chart = DailyCashflow.where("user_id": current_user.id).where("currency_id": "2")
  #   @currency_usd_line_chart = DailyCashflow.where("user_id": current_user.id).where("currency_id": "1")
  #   @currency_usd = @daily_cash_flows.select {|e| e.currency.name == "USD"}
    

  #   @currency_usd_income = @currency_usd.select {|e| e.cashflow_type.trend == "Income"}.sum {|e| e.amount}
  #   @currency_usd_outcome = @currency_usd.select {|e| e.cashflow_type.trend == "Outcome"}.sum {|e| e.amount}
  #   @currency_usd_total = @currency_usd_income - @currency_usd_outcome


  #   @currency_vnd_income = @currency_vnd.select {|e| e.cashflow_type.trend == "Income"}.sum {|e| e.amount}
  #   @currency_vnd_outcome = @currency_vnd.select {|e| e.cashflow_type.trend == "Outcome"}.sum {|e| e.amount}
  #   @currency_vnd_total = @currency_vnd_income - @currency_vnd_outcome

    

    
  #   @incomes = @daily_cash_flows.select {|e| e.cashflow_type.trend == "Income"}.sum {|e| e.amount}
  #   @outcomes = @daily_cash_flows.select {|e| e.cashflow_type.trend == "Outcome"}.sum {|e| e.amount}
  #   @total = @incomes - @outcomes


  #   @income_all_purposes = Purpose.all.map.with_index do |purpose, index|
  #     current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |cf|
  #         cf.cashflow_type.trend == "Income" && cf.currency_id == 1
  #       end.sum{|e| e.amount}
  #     end 
  #   @test_graph_outcome = Purpose.all.map.with_index do |purpose, index|
  #     [purpose.purpose_name, current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
  #         type.cashflow_type.trend == "Outcome"
  #       end.sum{|e| e.amount}]
  #     end 
    
  #   @test_graph_income = Purpose.all.map.with_index do |purpose, index|
  #     [purpose.purpose_name, current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
  #         type.cashflow_type.trend == "Income"
  #       end.sum{|e| e.amount}]
  #     end 

  #   @outcome_all_purposes = Purpose.all.map.with_index do |purpose, index|
  #     current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.select do |type|
  #         type.cashflow_type.trend == "Outcome"
  #       end.sum{|e| e.amount}
  #     end 
  #   @all_purposes = Purpose.all.map.with_index do |purpose, index|
  #     current_user.daily_cashflows.select {|cashflow| cashflow.purpose_id == index + 1}.sum{|e| e.amount}
  #     end 
  #   #tim ngay gan nhat cua tat ca transactions
  #   @the_last_day = @daily_cash_flows.map {|e| e.occur_at.to_date }.max

  #   @the_last_day_cashflows = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }
  #   @the_last_day_cashflows_incomes = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }.select do |e|
  #                                       e.cashflow_type.trend == "Income"
  #                                     end.sum {|e| e.amount}
  #   @the_last_day_cashflows_outcomes = @daily_cash_flows.select {|e| e.occur_at.to_date == @the_last_day }.select do |e|
  #                                       e.cashflow_type.trend == "Outcome"
  #                                     end.sum {|e| e.amount}                                      
  #   @the_last_day_cashflows_total = @the_last_day_cashflows_incomes - @the_last_day_cashflows_outcomes
  # end 

  # def index_1
  #   @all_cashflows = DailyCashflow.where("user_id": current_user.id)
  #   @last_day = current_user.daily_cashflows.map {|e| e.occur_at.to_date }.max
  #   @last_day_cashflows = DailyCashflow.where("user_id": current_user.id).where("occur_at": @last_day)
  #   @currency_vnd_line_chart = DailyCashflow.where("user_id": current_user.id).where("currency_id": "2").where("occur_at > ? AND occur_at <= ?", 1.month.ago, @last_day)
  #   @currency_usd_income_line_chart = DailyCashflow.where("user_id": current_user.id).where("cashflow_type_id": "1").where("currency_id": "1")
  #   @currency_usd_outcome_line_chart = DailyCashflow.where("user_id": current_user.id).where("cashflow_type_id": "2").where("currency_id": "1").where("occur_at > ? AND occur_at <= ?", 1.month.ago, @last_day)
  #   @currency_vnd_income_line_chart = DailyCashflow.where("user_id": current_user.id).where("cashflow_type_id": "1").where("currency_id": "2")
  #   @currency_vnd_outcome_line_chart = DailyCashflow.where("user_id": current_user.id).where("cashflow_type_id": "2").where("currency_id": "2")
  #   @currency_vnd_income_line_chart_new = DailyCashflow.where("user_id": current_user.id).where("currency_id": "2")
  #   @test = @all_cashflows.where("currency_id": "2").where("cashflow_type_id": "1")
  # end 

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

  def index_2 
    @cashflows = DailyCashflow.where("user_id": current_user.id)
    @income_vnd = @cashflows.where("currency_id": "2").where("cashflow_type_id": "1")
    @outcome_vnd = @cashflows.where("currency_id": "2").where("cashflow_type_id": "2")
    @income_vnd_amount = @income_vnd.map {|e| e.amount}
    @outcome_vnd_amount = @outcome_vnd.map {|e| e.amount}
    # @total_vnd = [@income_vnd_amount, @outcome_vnd_amount].transpose.map {|e| e.sum}
    #Phai viet ham daily total rou
    @income_usd = @cashflows.where("currency_id": "1").where("cashflow_type_id": "1")
    @outcome_usd = @cashflows.where("currency_id": "1").where("cashflow_type_id": "2")
    @pie_vnd = CashflowType.all.map.with_index do |type, index|
      [type.trend, @cashflows.select {|cf| cf.cashflow_type_id == index + 1 && cf.currency_id == "2"}.sum{|e| e.amount} ]
    end 
    @pie_usd = CashflowType.all.map.with_index do |type, index|
      [type.trend, @cashflows.select {|cf| cf.cashflow_type_id == index + 1 && cf.currency_id == "1"}.sum {|e| e.amount} ]
    end 
    
    @last_week_cashflows = DailyCashflow.where("occur_at >= ? AND occur_at <= ?", 1.week.ago, Time.now)
    @last_week_vnd_income = @last_week_cashflows.where("currency_id": "2").where("cashflow_type_id": "1")
    @last_week_vnd_outcome = @last_week_cashflows.where("currency_id": "2").where("cashflow_type_id": "2")
    
    @last_day = @cashflows.map {|e| e.occur_at.to_date}.max
    @last_day_cashflows = @cashflows.where("occur_at": @last_day)
    @last_day_vnd_income_purpose = Purpose.all.map.with_index do |purpose, index|
      [ purpose.purpose_name, @last_day_cashflows.select do |cf| 
        (cf.purpose_id == index + 1 && cf.currency_id == "2" && cf.cashflow_type.trend == "Income")
      end.sum {|e| e.amount } ]
    end 

    @last_day_vnd_outcome_purpose = Purpose.all.map.with_index do |purpose, index|
      [ purpose.purpose_name, 
        @last_day_cashflows.select do |cf|
          (cf.purpose_id == index + 1 && cf.currency_id == "2" && cf.cashflow_type.trend == "Outcome")
        end.sum {|e| e.amount} ]
    end 

    @last_day_usd_income_purpose = Purpose.all.map.with_index do |purpose, index|
      [ purpose.purpose_name, @last_day_cashflows.select do |cf| 
        (cf.purpose_id == index + 1 && cf.currency_id == "1" && cf.cashflow_type.trend == "Income")
      end.sum {|e| e.amount } ]
    end 



    @last_day_usd_outcome_purpose = Purpose.all.map.with_index do |purpose, index|
      [ purpose.purpose_name, 
        @last_day_cashflows.select do |cf|
          (cf.purpose_id == index + 1 && cf.currency_id == "1" && cf.cashflow_type.trend == "Outcome")
        end.sum {|e| e.amount} ]
    end 

  end

  def daily_report
    #Daily report se co gi?
    # 1. Pie daily income, outcome vnd xong
    # 2. Pie daily income, outcome usd 
    # 3. Pie donut daily purpose income/outcome vnd xong  
    # 4. Pie donut daily purpose income/outcome usd xong
    # 5. Line 1.week.ago income/outcome vnd xong 
    # 6. Line 1.week.ago income/outcome usd xong
    # 7. list as file excel xong

    
    @last_day = current_user.last_date
    @last_day_cashflows = current_user.last_date_cashflows
    @last_day_cashflows_vnd = current_user.cashflow_by_day(@last_day, "VND")
    @last_day_cashflows_usd = current_user.cashflow_by_day(@last_day, "USD")

    @last_day_vnd_income = current_user.sum_by_day(@last_day, "VND")["Income"]
    @last_day_vnd_outcome = current_user.sum_by_day(@last_day, "VND")["Outcome"]
    @last_day_vnd_total = @last_day_vnd_income - @last_day_vnd_outcome 
    @last_day_usd_income = current_user.sum_by_day(@last_day, "USD")["Income"]
    @last_day_usd_outcome = current_user.sum_by_day(@last_day, "USD")["Outcome"]
    @last_day_usd_total = @last_day_usd_income - @last_day_usd_outcome 

    @last_day_vnd_income_purpose = current_user.cashflow_by_day_purpose(@last_day, "VND", "Income")
    @last_day_vnd_outcome_purpose = current_user.cashflow_by_day_purpose(@last_day, "VND", "Outcome")
    @this_week_vnd_cashflows = current_user.cashflow_by_between(Date.today.beginning_of_week, Date.today, "VND")
    @this_week_usd_cashflows = current_user.cashflow_by_between(Date.today.beginning_of_week, Date.today, "USD")
    @this_week_usd_cashflows = current_user.daily_cashflows.between(Date.today.beginning_of_week, Date.today).where(currency: "USD").where(cashflow_type: "Income")



    
    
    
  end 


  def monthly_report
    @cashflows = DailyCashflow.where("user_id": current_user.id)
    @monthly_cashflows = @cashflows.where("date(occur_at) > (?) AND date(occur_at) < (?)", 1.month.ago.beginning_of_month, 1.month.ago.end_of_month)
    @cashflows_vnd_income = @monthly_cashflows.where("currency_id": "2").where("cashflow_type_id": "1")
    @cashflows_vnd_outcome = @monthly_cashflows.where("currency_id": "2").where("cashflow_type_id": "2")
    @cashflows_usd_income = @monthly_cashflows.where("currency_id": "1").where("cashflow_type_id": "1")
    @cashflows_usd_outcome = @monthly_cashflows.where("currency_id": "1").where("cashflow_type_id": "2") 
    
  end  

end
