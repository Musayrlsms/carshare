# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_customer_id     :string
#  mobile_number          :string
#  adress                 :string
#  date_of_birth          :date
#  name                   :string
#  surname                :string
#  document_status        :integer          default("pending")
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :stripe_account
  has_one :stripe_customer
  has_one :bank_account
  
  has_many :cars

  has_one_attached :avatar
  has_one_attached :identity_card
  has_one_attached :passport
  has_one_attached :driver_license
  enum document_status: { pending: 0, approved: 1, rejected: 2 }

  after_save :create_stripe_account
  after_save :create_stripe_customer

  def document_upload?
      document_status != "approved" && self.identity_card.present? && self.passport.present? && self.driver_license.present?
  end

  def full_name
    "#{self.name} #{self.surname}"
  end

  def create_stripe_account
    if approved? && name.present? && surname.present? && self.stripe_account.nil? && adress.present? && date_of_birth.present? && mobile_number.present?
      create_stripe_account_request = Stripe::Account.create(
        type: 'custom',
        country: 'HR',
        capabilities: {
          card_payments: {requested: true},
          transfers: {requested: true},
        }, 
        business_type: 'individual',
        individual: {
          first_name: self.name,
          last_name: self.surname,
          dob: {
            day: date_of_birth.day.to_s,
            month: date_of_birth.month.to_s,
            year: date_of_birth.year.to_s,
          },
          address: {
            line1: adress,
            postal_code: adress,
            city: adress
          },
          email: email,
          phone: mobile_number
        },
        business_profile: {
          product_description: 'Fundraising campaign',
          mcc: '5818'
        },
        tos_acceptance: {
          date: Time.now.to_i,
          ip: last_sign_in_ip || "4.4.4.4"
        }
      )
      Rails.logger.info "Kullanici stripeda olusturuldu"
      Rails.logger.info create_stripe_account_request

      sa = StripeAccount.new(account_id: create_stripe_account_request.id, user: self)
      sa.save!
    end
  end

  def create_stripe_customer
    if approved? && name.present? && surname.present? && self.stripe_customer.nil? && adress.present? && date_of_birth.present? && mobile_number.present?
      create_stripe_customer_request = Stripe::Customer.create(
        email: email,
      )
      Rails.logger.info "Musteri stripeda olusturuldu"
      Rails.logger.info create_stripe_customer_request

      sc = StripeCustomer.new(customer_id: create_stripe_customer_request.id, user: self)
      sc.save!
    end
  end
end
