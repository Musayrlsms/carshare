class Rule < ApplicationRecord
    has_many :rule_cars
    has_many :cars, through: :rule_cars
end
