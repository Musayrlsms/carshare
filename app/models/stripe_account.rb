# == Schema Information
#
# Table name: stripe_accounts
#
#  id           :bigint           not null, primary key
#  first_name   :string
#  last_name    :string
#  account_type :string
#  dob_month    :string
#  dob_day      :string
#  dob_year     :string
#  phone        :string
#  email        :string
#  address_line :string
#  postal_code  :string
#  city         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  account_id   :string
#
class StripeAccount < ApplicationRecord
  belongs_to :user
end
