class Rent < ApplicationRecord
  belongs_to :car
  belongs_to :renter
  belongs_to :owner
end
