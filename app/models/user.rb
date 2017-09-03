class User < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
  has_secure_password
  has_many :daily_cashflows, dependent: :destroy
end
