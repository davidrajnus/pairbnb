class ReservationMailer < ApplicationMailer

  def booking_email(id)
    @user=User.find(id)
    @customer = @user.first_name
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')

  end

end
