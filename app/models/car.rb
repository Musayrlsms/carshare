class Car < ApplicationRecord
  belongs_to :model
  belongs_to :brand
  belongs_to :user
  has_many :rents
  has_many_attached :images
end
