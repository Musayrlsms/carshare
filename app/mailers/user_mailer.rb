class UserMailer < ApplicationMailer
  def approved_email(user)
    @user = user
    mail(to: @user.email, subject: 'Account accepted')
  end
end
