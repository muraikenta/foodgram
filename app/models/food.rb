class Food < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validates :user_id, presence: true
end
