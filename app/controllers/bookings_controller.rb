 class BookingsController < ApplicationController
  def create
    #Finds all the information of the listing for this booking
    @listing = Listing.find(params[:listing_id])

    #creates a booking object with the current_user id, together with the params from the form
    @booking = current_user.bookings.new(booking_params)

    #all the listing information is stored with the booking, which in this case is the listing id in booking
    @booking.listing = @listing
    if @booking.save
      redirect_to current_user
    else
      render "listings/show"
    end
  end

  def destroy
  end

  private
    def booking_params
        #what this does is to say that the listing object can only pass in these following params
        params.require(:booking).permit(:num_guests, :start_date, :end_date)
    end
end
