class User < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
  has_secure_password
end
