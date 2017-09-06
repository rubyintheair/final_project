class TermsController < ApplicationController
  def new
  end

  def create 
    @term = Term.new(term_params)
    if @term.save
      flash[:success] = "Create a term successfully"
      redirect_to terms_path
    else 
      flash[:error] = "Khong tao duoc Term #{@term.errors.full_messages.to_sentence}"
      redirect_to new_term_path
    end 
  end 

  def index
  end

  def term_params
    params.require(:term).permit(:month)
  end 
end
