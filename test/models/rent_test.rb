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
require "test_helper"

class RentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
