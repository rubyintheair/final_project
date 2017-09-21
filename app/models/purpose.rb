class Purpose < ApplicationRecord
  validates :purpose_name, presence: true, uniqueness: true
  has_many :daily_cashflows

  @all_purposes = ["Housing","Food", "Clothing", "Medical/Healthcare", 
  "Savings and Insurance", "Entertainment", "Beauty", "Travel", "Education", "Kids",
  "Transportation", "Utilities"]

  def icon_class 
    case purpose_name 
    when "Housing" then "home"
    when "Food" then "cutlery"
    when "Clothing" then "eye"
    when /Medical/ then "ambulance"
    when /Savings/ then "money"
    when "Entertainment" then "coffee"
    when "Beauty" then "shopping-bag"
    when "Travel" then "suitcase"
    when "Education" then "graduation-cap"
    when "Kids" then "child"
    when "Transportation" then "car"
    else "question" 
    end 
  end 

  def icon_display 
    case purpose_name
    when "Housing" then "http://www.avondaleaz.gov/home/showimage?id=752"
    when "Food" then "https://www.iconexperience.com/_img/g_collection_png/standard/512x512/hamburger.png"
    when "Clothing" then "http://www.myiconfinder.com/uploads/iconsets/9b11c4309031908f3c2f979686b04e16.png"
    when /Medical/ then "http://www.playamedical.com/images/2013/04/medical-icon-png-33.png"
    when /Savings/ then "https://icon-icons.com/icons2/516/PNG/512/coin_money_icon-icons.com_51091.png"
    when "Entertainment" then "https://cdn3.iconfinder.com/data/icons/black-easy/512/538309-game_512x512.png"
    when "Beauty" then "http://cdnjs.cloudflare.com/ajax/libs/emojione/2.2.6/assets/svg/1f484.svg"
    when "Travel" then "https://cdn4.iconfinder.com/data/icons/travel-gang/512/Travel_23-512.png"
    when "Education" then "https://image.flaticon.com/icons/svg/201/201614.svg"
    when "Kids" then "http://icons.iconarchive.com/icons/dapino/baby-boy/256/baby-sucking-icon.png"
    when "Transportation" then "https://png.icons8.com/ground-transportation/office/1600"
    when "Utilities" then "https://www.iconexperience.com/_img/g_collection_png/standard/512x512/water_tap.png"
    else "http://images1.cafef.vn/Images/Uploaded/DuLieuDownload/logodn/SSI.jpg" 
    end 
  end 

end
