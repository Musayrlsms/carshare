# == Schema Information
#
# Table name: rules
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Rule < ApplicationRecord
    has_many :rule_cars
    has_many :cars, through: :rule_cars
end
