class DailyCashflowsController < ApplicationController
  def new
    @daily_cash_flow = current_user.daily_cashflows.build
    @cashflow_types = CashflowType.all
    @friends = Friend.all 
    @purposes = Purpose.all 
  end

  def index
  end
end
