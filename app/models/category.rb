class Category < ApplicationRecord
  validates :type, presence: true, uniqueness: true
end
