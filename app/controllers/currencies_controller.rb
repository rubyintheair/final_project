class CurrenciesController < ApplicationController
  def new
  end

  def create 
    @currency = Currency.new(currency_params)
    if @currency.save 
      flash[:success] = "Quy da tao Currency thanh cong"
      redirect_to currencies_path
    else 
      flash[:error] = "Quy khong the tao Currency roi #{@currency.errors.full_messages.to_sentence}"
      redirect_to new_currency_path
    end 
  end 

  def index
    @currencies = Currency.all
  end

  def currency_params
    params.require(:currency).permit(:name)
  end 
end
