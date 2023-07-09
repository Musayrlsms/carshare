# == Schema Information
#
# Table name: cars
#
#  id           :bigint           not null, primary key
#  details      :text
#  model_id     :bigint           not null
#  brand_id     :bigint           not null
#  user_id      :bigint           not null
#  distance     :integer
#  max_luggage  :integer
#  seat_count   :integer
#  case_type    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  price        :float            default(0.0), not null
#  email        :string
#  phone_number :string
#  user_name    :string
#  user_surname :string
#  address      :string
#  state        :string
#  city         :string
#  model_year   :integer
#  status       :integer          default("available"), not null
#
class Car < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["address","price", "brand_id", "case_type", "city", "created_at", "details", "distance", "id", "max_luggage", "model_id", "model_year"]
  end
  
  belongs_to :model
  belongs_to :brand
  belongs_to :user
  has_many :rents
  
  has_many_attached :images
  validates :user_id, presence: true
  enum status: { available: 0, rejected: 1, approved: 2 }

  def busy_days
    rents.paid.map do |rent|
      {
          from: rent.start_date.strftime('%d/%m/%Y'),
          to: rent.finish_date.strftime('%d/%m/%Y')
      }
    end.to_json
  end

  def self.ransackable_associations(auth_object = nil)
    ["brand", "model", "user"]
  end
end
