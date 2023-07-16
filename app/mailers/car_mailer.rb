class CarMailer < ApplicationMailer
  def approved_email(car)
    @car = car
    @user = car.user
    mail(to: @user.email, subject: 'Car information approved')
  end
end
