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
require "test_helper"

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
