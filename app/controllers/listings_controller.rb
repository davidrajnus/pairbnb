class ListingsController < ApplicationController
  #find_listing is a method that finds an object of a particular id
  #before_action runs for find_listing for the following methods, so that you dont have to
  #specify in the method itself
  before_action :find_listing, only: [:show, :update, :edit, :destroy]

  def index
    @listings = Listing.all
    render "listings/index"
  end

  #initialize a new object when the page is loaded, which makes is ready to receive from a form
  def new

    @listing = Listing.new
    render "listings/new"
  end

  

  def create
    # listing_params.user << user_id: current_user.id
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

   if @listing.save
     redirect_to @listing
   else
     @errors = @user.errors.full_messages
     flash[:error] = @errors
     render "listings/show"
     # render template: "users/new"
   end
  end

  #shows a page for that object of that ID
  def show
    @booking = @listing.bookings.new


  end

  def edit

  end

  def update

  end

  def destroy

  end

  #private so that people cant access these methods
  private
    def listing_params
        #what this does is to say that the listing object can only pass in these following params
        params.require(:listing).permit(:user_id, :name, :place_type, :property_type, :room_number, :bed_number, 
                                        :guest_number, :address, :zipcode, :city, :state, :country,
                                        :price, :description, {avatars: []})
    end

    def find_listing
        @listing = Listing.find(params[:id])
    end

end

