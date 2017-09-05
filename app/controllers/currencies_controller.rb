class CurrenciesController < ApplicationController
  def new
  end

  def create 
    @currency = Currency.new(currency_params)
    if @currency.save 
      flash[:success] = "Quy da tao Currency thanh cong"
      render "index"
    else 
      flash[:error] = "Quy khong the tao Currency roi #{@currency.errors.full_messages.to_sentence}"
      render "new"
    end 
  end 

  def index
  end

  def currency_params
    params.require(:currency).permit(:name)
  end 
end
