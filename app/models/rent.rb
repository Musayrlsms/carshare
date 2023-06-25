# == Schema Information
#
# Table name: rents
#
#  id                      :bigint           not null, primary key
#  car_id                  :bigint           not null
#  renter_id               :bigint           not null
#  owner_id                :bigint           not null
#  start_date              :datetime
#  finish_date             :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  payment_intent_response :jsonb
#  payment_status          :integer          default("pending")
#  amount                  :float
#  payment_intent_id       :string
#
class Rent < ApplicationRecord
  belongs_to :car
  belongs_to :renter, class_name: 'User', foreign_key: 'renter_id'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  enum payment_status: [:pending, :paid, :void, :canceled]
end
