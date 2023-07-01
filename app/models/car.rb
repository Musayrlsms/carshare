class Car < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["address","price", "brand_id", "case_type", "city", "created_at", "details", "distance", "id", "max_luggage", "model_id", "model_year"]
  end
  
  belongs_to :model
  belongs_to :brand
  belongs_to :user
  has_many_attached :images
  validates :user_id, presence: true
  enum status: { available: 0, rejected: 1, approved: 2 }

  def self.ransackable_associations(auth_object = nil)
    ["brand", "model", "user"]
  end
end
