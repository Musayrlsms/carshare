class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum document_status: { pending: 0, approved: 1, rejected: 2 }
  enum role: { user: 0, admin: 1 }

  has_one_attached :avatar
  has_one_attached :identity_card
  has_one_attached :passport
  has_one_attached :driver_license


  def document_upload?
      document_status != "approved" && self.identity_card.present? && self.passport.present? && self.driver_license.present?
  end

  def full_name
    "#{self.name} #{self.surname}"
   end


end
