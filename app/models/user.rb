class User < ApplicationRecord
  has_many :notes
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
