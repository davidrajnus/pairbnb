class ReservationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    booking_email(args[current_user.id])
  end
end
