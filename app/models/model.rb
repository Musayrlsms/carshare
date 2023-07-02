# == Schema Information
#
# Table name: models
#
#  id         :bigint           not null, primary key
#  name       :string
#  brand_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Model < ApplicationRecord
  belongs_to :brand
  def self.ransackable_attributes(auth_object = nil)
    ["brand_id", "created_at", "id", "name", "updated_at"]
  end
end
