class Model < ApplicationRecord
  belongs_to :brand
  def self.ransackable_attributes(auth_object = nil)
    ["brand_id", "created_at", "id", "name", "updated_at"]
  end
end
