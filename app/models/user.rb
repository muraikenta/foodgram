class User < ApplicationRecord
  has_many :foods
  has_many :likes

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
