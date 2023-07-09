# == Schema Information
#
# Table name: properties
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Property < ApplicationRecord
end
