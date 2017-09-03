
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
