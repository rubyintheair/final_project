class Purpose < ApplicationRecord
  validates :purpose_name, presence: true, uniqueness: true
end
