class Brand < ApplicationRecord
  has_one_attached :logo

  has_many :model
end