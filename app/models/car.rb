class Car < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["address","price", "brand_id", "case_type", "city", "created_at", "details", "distance", "email", "id", "max_luggage", "model_id", "model_year", "phone_number", "price", "seat_count", "state", "status", "updated_at", "user_id", "user_name", "user_surname"]
  end
  
  belongs_to :model
  belongs_to :brand
  belongs_to :user
  has_many_attached :images
  enum status: { available: 0, rejected: 1, approved: 2 }


end
