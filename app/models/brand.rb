class Brand < ApplicationRecord
  has_one_attached :logo

  has_many :models
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["logo_attachment", "logo_blob", "models"]
  end
end
