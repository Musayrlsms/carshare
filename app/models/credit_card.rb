# == Schema Information
#
# Table name: credit_cards
#
#  id                    :bigint           not null, primary key
#  stripe_credit_card_id :string
#  last_four_digits      :string
#  user_id               :bigint           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class CreditCard < ApplicationRecord
  belongs_to :user
end
