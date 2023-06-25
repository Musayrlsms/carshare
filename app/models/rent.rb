class Rent < ApplicationRecord
  belongs_to :car
  belongs_to :renter, class_name: 'User', foreign_key: 'renter_id'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  enum payment_status: [:pending, :paid, :void, :canceled]
end
