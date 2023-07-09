class RuleCar < ApplicationRecord
  belongs_to :rule
  belongs_to :car
end
