
  def create
    @category = Category.new(category_params)
    if @category.save 
      flash[:success] = "Quy da tao category thanh cong"
      render "index"
    else
      flash[:error] = "Tao category fail rou, Quy rang tao lai nha #{@category.errors.full_messages.to_sentence}"
      render "new"
    end 
  end 

  def category_params
    params.require(:category).permit(:type_name)
  end 

  def index
    @categories = Category.all
  end 
def search
    @cashflows = current_user.daily_cashflows
    if (params[:purposes_id] == "14")
      if (params[:start_date] && params[:end_date])
        @period_cashflows = DailyCashflow.where("date(occur_at) in (?)", params[:start_date])
        @period_cashflows = @cashflows.select {|e| e.occur_at.to_date == params[:start_date]}
        flash[:success] = "We have searched based on START_DATE and END_DATE"
      else 
        flash[:error] = "Nothing in the params"
      end
    else 
      if (params[:start_date] && params[:end_date])
        @period_cashflows = DailyCashflow.where("date(occur_at) in (?)", 
                            params[:start_date]).select {|e| e.purpose_id == params[:purposes_id].to_i}
        flash[:success] = "We have searched based on START_DATE, END_DATE and PURPOSE"
      elsif (params[:purposes_id].to_i) 
        flash[:success] = "We have searched based on PURPOSE"
        @period_cashflows = DailyCashflow.where("purpose_id": params[:purposes_id].to_i)  
      end 
    end 
    
    @incomes = @period_cashflows.select { |e| e.cashflow_type_id == 2 }.sum {|e| e.amount }
    @outcomes = @period_cashflows.select { |e| e.cashflow_type_id == 3}.sum {|e| e.amount}
    @total = @incomes - @outcomes
  
  end 