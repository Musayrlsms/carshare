class Car < ApplicationRecord
  belongs_to :model
  belongs_to :brand
  belongs_to :user
  has_many_attached :images
  validates :user_id, presence: true
  enum status: { available: 0, rejected: 1, approved: 2 }
end
