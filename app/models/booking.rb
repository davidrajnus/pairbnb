class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  #validates if booking is overlapping with previous bookings
  validate :check_overlapping_dates
  #validates if guest staying does not exceed the max allowed guest in listing
  validate :check_num_guests

  def check_overlapping_dates
    #compare this new booking with existing bookings
    listing.bookings.each do |old_booking|
      if overlap?(self, old_booking)
        return errors.add(:overlapping_dates, "The booking dates are taken") 
      end
    end 
  end

  def overlap?(x,y)
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end

  def check_num_guests
    max_guests = listing.guest_number
    return if num_guests < max_guests
    errors.add(:num_guests, "Number of guests exceeded")
  end

  def total_price
    price = listing.price
    num_dates = (start_date..end_date).to_a.length
    return price*num_dates

  end
end
