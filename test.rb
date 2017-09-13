
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


  <% @currency_vnd_incomes.each do |e| %>
  Purpose: <%= e.purpose.purpose_name %><br>
  Currency: <%= e.currency.name %><br>
  Amount: <%= e.amount %><br>
  Currency_id : <%= e.currency_id %><br>
  ===================
<% end %>

<%= @currency_vnd_incomes   %>

<%= @cashflow_currency_income.each_with_index do |e, index| %>
  <% unless index == @cashflow_currency_income.count - 1 %>
    <%= e %>
    <%= e.count %><br>
  <% else %>
    <br>
    This is an array
    <%= e.count %>
    <%= e.class %>
    <%= e.count %>
    <% e.each do |cf| %>
      <%= cf.currency %>
      <%= cf.purpose.purpose_name %>
      <%= e.count %>
    <% end %>
  <% end %>
<% end %>


<h1>Welcome to monthly report</h1>High top: <%= DailyCashflow.top([:occur_at, :cashflow_type, :purpose_id, :amount])%>
Test average <%= line_chart current_user.daily_cashflows.where(currency: "VND").where(cashflow_type: "Income").group_by_month(:occur_at).average(:amount) %>